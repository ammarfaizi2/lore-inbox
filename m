Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932686AbWKEOAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686AbWKEOAP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 09:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932689AbWKEOAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 09:00:15 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.8]:1810 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S932686AbWKEOAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 09:00:13 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Scsi cdrom naming confusion; sr or scd?
Date: Sun, 5 Nov 2006 14:00:11 +0000
User-Agent: KMail/1.9.5
Cc: andrew@walrond.org, linux-kernel@vger.kernel.org
References: <20061105100926.GA2883@pelagius.h-e-r-e-s-y.com> <Pine.LNX.4.61.0611051232580.12727@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0611051232580.12727@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611051400.11918.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 November 2006 11:33, Jan Engelhardt wrote:
> > "The prefix /dev/sr (instead of /dev/scd) has been deprecated"
> >
> >but booting 2.6.18.2 from a scsi CD only works if I pass the kernel
> >parameter root=/dev/sr0 and fails with root=/dev/scd0
> >
> >I guess the kernel ought to be taught about the scd* names aswell?
>
> brw-r-----  1 root disk 11, 0 Mar 19  2005 /dev/scd0
> brw-r-----  1 root disk 11, 0 Mar 19  2005 /dev/sr0
>
> Plus I see sr0 being far more commonly used than scd0.
> So I guess the doc is wrong.

udev only creates /dev/sr0, so I'm inclined to agree.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
