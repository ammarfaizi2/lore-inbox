Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263860AbUEXDKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263860AbUEXDKQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 23:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263862AbUEXDKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 23:10:15 -0400
Received: from main.gmane.org ([80.91.224.249]:60038 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263860AbUEXDKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 23:10:12 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Daniel Pittman <daniel@rimspace.net>
Subject: Re: Linux Kernel 2.6.6 IDE shutdown problems.
Date: Mon, 24 May 2004 13:09:08 +1000
Message-ID: <87fz9qseqz.fsf@enki.rimspace.net>
References: <BAY18-F105X7rz6AvEm0002622f@hotmail.com>
	<200405151506.20765.bzolnier@elka.pw.edu.pl>
	<c8bdqv$lib$1@gatekeeper.tmr.com> <20040524024136.GB2502@zero>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 203-217-29-45.perm.iinet.net.au
User-Agent: Gnus/5.110003 (No Gnus v0.3) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:e7hzxEJhWLDDfbg6EklVdDxbqBQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 May 2004, Tom Vier wrote:
> On Mon, May 17, 2004 at 06:25:51PM -0400, Bill Davidsen wrote:
>> I would think that if the drive didn't properly flush cache on
>> shutdown that it might cause corruption. Feel free to tell me no
>> drive would bahave like that ;-)
>
> why not add a one or two second delay before? i doubt any drive holds
> its writeback that long.

This was the solution adopted by IBM, for their Thinkpad laptop line, in
a BIOS update last year.  My system now delays two seconds before
turning off, with the stated purpose "avoiding disk corruption"...

        Daniel

-- 
The English have the most rigid code of immorality in the world.
        -- Malcom Bradbury, _Eating People is Wrong_

