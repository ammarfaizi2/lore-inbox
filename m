Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965008AbWFNPin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbWFNPin (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 11:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbWFNPim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 11:38:42 -0400
Received: from asclepius.uwa.edu.au ([130.95.128.56]:14725 "EHLO
	asclepius.uwa.edu.au") by vger.kernel.org with ESMTP
	id S965008AbWFNPim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 11:38:42 -0400
X-UWA-Client-IP: 130.95.13.9 (UWA)
Date: Wed, 14 Jun 2006 23:38:37 +0800
From: Bernard Blackham <b-lkml@blackham.com.au>
To: Fengguang Wu <fengguang.wu@gmail.com>, linux-kernel@vger.kernel.org,
       Lubos Lunak <l.lunak@suse.cz>, Dirk Mueller <dmueller@suse.de>,
       Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] the /proc/filecache interface
Message-ID: <20060614153837.GA16601@ucc.gu.uwa.edu.au>
References: <20060612075130.GA5432@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060612075130.GA5432@mail.ustc.edu.cn>
Organization: Dagobah Systems
User-Agent: Mutt/1.5.11+cvs20060403
X-SpamTest-Info: Profile: Formal (396/060608)
X-SpamTest-Info: Profile: Detect Hard [UCS 290904]
X-SpamTest-Info: Profile: SysLog
X-SpamTest-Info: Profile: Marking Spam - Subject (UCS) [02-08-04]
X-SpamTest-Status: Not detected
X-SpamTest-Version: SMTP-Filter Version 2.0.0 [0125], KAS/Release
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2006 at 03:51:30PM +0800, Fengguang Wu wrote:
> The /proc/filecache support has been half done. And I'd like to hear
> early comments on the interface.

Hi,

I haven't been following this closely, so I apologise if I'm out of
my depth. It would be a useful add-on to be able to use this
interface to force something _out_ of the page cache also. For
example, for performance tests, or selectively ditching pages before
software suspending.

I realise it'd probably be much more work and more intrusive than
the current patch - though perhaps just considering the possibility
of this in the interface, so that the interface could be reused if
the feature was added later?

Kind regards,

Bernard.

