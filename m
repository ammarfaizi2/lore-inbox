Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263542AbTEIW1V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 18:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263548AbTEIW1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 18:27:21 -0400
Received: from mail.ccur.com ([208.248.32.212]:24585 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S263542AbTEIW1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 18:27:20 -0400
Date: Fri, 9 May 2003 18:39:28 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Riley Williams <Riley@Williams.Name>
Cc: Andy Pfiffer <andyp@osdl.org>, Christophe Saout <christophe@saout.de>,
       linux-kernel@vger.kernel.org
Subject: Re: ext3/lilo/2.5.6[89] (was: [KEXEC][2.5.69] kexec for 2.5.69available)
Message-ID: <20030509223928.GA21887@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <1052513725.15923.45.camel@andyp.pdx.osdl.net> <BKEGKPICNAKILKJKMHCACEJHCLAA.Riley@Williams.Name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BKEGKPICNAKILKJKMHCACEJHCLAA.Riley@Williams.Name>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> One suggestion: ext3 is a journalled version of ext2, so if you can
> boot with whatever is needed to specify that the boot partition is
> to be mounted as ext2 rather than ext3, you can isolate the journal
> system: If the problem's still there in ext2 then the journal is
> not involved, but if the problem vanishes there, it's something to
> do with the journal.
> 
> I have to admit that the above sounds very much like the details
> are being recorded in the journal, but the journal isn't being
> played back to update the actual files.

I recall reading on lkml once that an ext3 sync(2) merely pushes volatile
data/metadata out to the journal rather than to to files themselves.

Joe
