Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274931AbTHFInv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 04:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274935AbTHFInv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 04:43:51 -0400
Received: from mail.uptime.at ([62.116.87.11]:27030 "EHLO mail.uptime.at")
	by vger.kernel.org with ESMTP id S274931AbTHFInj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 04:43:39 -0400
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: "'Olaf Titz'" <olaf@bigred.inka.de>, <linux-kernel@vger.kernel.org>,
       "=?us-ascii?Q?'Herbert_Potzl'?=" <herbert@13thfloor.at>
Subject: RE: chroot() breaks syslog() ?
Date: Wed, 6 Aug 2003 10:42:40 +0200
Organization: UPtime system solutions
Message-ID: <000701c35bf6$b370ea70$020b10ac@pitzeier.priv.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: 
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
X-MailScanner-Information: Please contact UPtime Systemloesungen for more information
X-MailScanner: clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-5.8,
	required 4.1, BAYES_01 -5.40, QUOTED_EMAIL_TEXT -0.38)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > IMHO, devfs in chroot environment, is defeating the purpose 
> > because if you have access to raw devices, like the device
> > your chroot dir is on, 
> > you can easily mount that device again, and voila you have 
> > access to 
> > the full tree, if you
> 
> You need to be root to mount the device, and as root you can 
> also create the device special file. A chroot environment 
> does not reliably guard against root breaking out of it.

That's not completly wrong nor is it completly true. :)

You _CAN_ guard yourself from root's breaking out of some chroot environment.
Using grsec (www.grsecurity.net). Denying double-chroots, creation of special
files within chroot-environments and if you like it... Deny mounting within
chroot. :)

There are many options provided - just use 'em. :)

Best regards,
 Oliver

