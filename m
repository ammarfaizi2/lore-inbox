Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759225AbWLAGip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759225AbWLAGip (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 01:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759233AbWLAGip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 01:38:45 -0500
Received: from nz-out-0506.google.com ([64.233.162.231]:26298 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1759225AbWLAGip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 01:38:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:thread-index:x-mimeole;
        b=a50LpGPfrwx+5/wLTAiYe1wDONN8xeig8BDCl22ecw1ZCz2Fi1Du8x8Mlimg1iJ4gSk2lwDGUARLC+7uGMYRkQ8zPdkvP/g00q2SVmbe95QptlyN9krXO3pr8f6iyhFF3A7gVifaEFOX2bj/WMCvo/Hfs+lQ+t/RzN54ZB/NsVo=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Adrian Bunk'" <bunk@stusta.de>
Cc: <tigran@aivazian.fsnet.co.uk>, <linux-kernel@vger.kernel.org>
Subject: RE: [2.6 patch] Tigran Aivazian: remove bouncing email addresses
Date: Thu, 30 Nov 2006 22:38:43 -0800
Message-ID: <00e901c71513$5f8397d0$6721100a@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20061201061958.GL11084@stusta.de>
Thread-Index: AccVELX4mtlmefp2RuCs45EEtMp5OgAAdxpg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Nov 30, 2006 at 10:00:35PM -0800, Hua Zhong wrote:
> 
> > I am curious, what's the point?
> 
> Email addresses are for contacting people.

Do you go back and change all the signed-off lines too when people change jobs?
 
> > These email addresses serve a "historical" purpose: they tell
> > when the contribution was made,  what the author's email addresses 
> > were at that point.
> 
> For historical purposes, you can always use historical kernels.

Then remove all the lines like the following:

- *	1.0	16 Feb 2000, Tigran Aivazian <tigran@sco.com>
+ *	1.0	16 Feb 2000, Tigran Aivazian
  *		Initial release.
- *	1.01	18 Feb 2000, Tigran Aivazian <tigran@sco.com>
+ *	1.01	18 Feb 2000, Tigran Aivazian 
  *		Added read() support + cleanups.

If you keep them, they tell the history and email addresses are part of the history.

Or simply remove all the history and tell people to look for the information in git changelogs.

The way you are doing it, serves no purpose other than losing information.

> > It's not MAINTAINERS. If people want to contact someone, go 
> > find the latest address there.
> 
> It's also MODULE_AUTHOR() and printk() which are far more 
> user-visible than MAINTAINERS.

Those are OK. But majority of you patch isn't the case.

