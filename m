Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWFTVed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWFTVed (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 17:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWFTVed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 17:34:33 -0400
Received: from barracuda.s2io.com ([72.1.205.138]:38844 "EHLO
	barracuda.mail.s2io.com") by vger.kernel.org with ESMTP
	id S1751201AbWFTVeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 17:34:31 -0400
X-ASG-Debug-ID: 1150839270-26565-443-0
X-Barracuda-URL: http://72.1.205.138:8000/cgi-bin/mark.cgi
X-ASG-Whitelist: Client
Reply-To: <ravinandan.arakali@neterion.com>
From: "Ravinandan Arakali" <ravinandan.arakali@neterion.com>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: <tglx@linutronix.de>, <dgc@sgi.com>, <mingo@elte.hu>, <neilb@suse.de>,
       <jblunck@suse.de>, <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
       <balbir@in.ibm.com>, <ananda.raju@neterion.com>,
       <leonid.grossman@neterion.com>,
       "'Jes Sorensen'" <jes@trained-monkey.org>
X-ASG-Orig-Subj: RE: [patch 0/5] [PATCH,RFC] vfs: per-superblock unused dentries list (2nd version)
Subject: RE: [patch 0/5] [PATCH,RFC] vfs: per-superblock unused dentries list (2nd version)
Date: Tue, 20 Jun 2006 14:34:05 -0700
Message-ID: <006d01c694b1$4208c0f0$3e10100a@pc.s2io.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20060619173712.1144b332.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Importance: Normal
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=3.5 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you want the patch to be submitted to netdev(the mailing list that we
usually submit to) ?

Ravi

-----Original Message-----
From: Andrew Morton [mailto:akpm@osdl.org]
Sent: Monday, June 19, 2006 5:37 PM
To: ravinandan.arakali@neterion.com
Cc: tglx@linutronix.de; dgc@sgi.com; mingo@elte.hu; neilb@suse.de;
jblunck@suse.de; linux-kernel@vger.kernel.org;
linux-fsdevel@vger.kernel.org; viro@zeniv.linux.org.uk;
balbir@in.ibm.com; ananda.raju@neterion.com;
leonid.grossman@neterion.com; Jes Sorensen
Subject: Re: [patch 0/5] [PATCH,RFC] vfs: per-superblock unused dentries
list (2nd version)


"Ravinandan Arakali" <ravinandan.arakali@neterion.com> wrote:
>
> This is a known problem and has been fixed in our internal source tree. We
> will be submitting the patch soon.

Please send me a copy asap - I urgently need to get the -mm patches vaguely
stabilised.

I'm somewhat surprised that the sn2 failed so seriously - I thought Jes was
testing that fairly regularly.

I think we kinda-sorta have a handle on the s2io->IRQ problem (although the
unexpectedly-held console spinlock is a mystery).

The scsi->BIO->mempool->slab crash is also a mystery.

Thanks.

