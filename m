Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266854AbUGVL7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266854AbUGVL7L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 07:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266855AbUGVL7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 07:59:11 -0400
Received: from tag.witbe.net ([81.88.96.48]:7892 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S266854AbUGVL7F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 07:59:05 -0400
Message-Id: <200407221158.i6MBwlb16284@tag.witbe.net>
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: "'James Morris'" <jmorris@redhat.com>, <dpf-lkml@fountainbay.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Delete cryptoloop
Date: Thu, 22 Jul 2004 13:58:41 +0200
Organization: AS2917
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <Pine.LNX.4.58.0407220110290.20963@devserv.devel.redhat.com>
Thread-Index: AcRvrAttK5CMh80FS3e9M9lB12To2AANvNDw
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Well, we have an option to be able to select EXPERIMENTAL code when
making a configuration, why not adding on option for DEPRECATED code ?

Then, you'd just have to migrate cryptoloop into this DEPRECATED
area.

Kconfig should be able to handle that very easily !

Regards,
Paul

Paul Rolland, rol(at)as2917.net
ex-AS2917 Network administrator and Peering Coordinator

--

Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un navigateur

"Some people dream of success... while others wake up and work hard at it" 

  

> -----Message d'origine-----
> De : linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] De la part de James Morris
> Envoyé : jeudi 22 juillet 2004 07:22
> À : dpf-lkml@fountainbay.com
> Cc : Andrew Morton; linux-kernel@vger.kernel.org
> Objet : Re: [PATCH] Delete cryptoloop
> 
> On Wed, 21 Jul 2004 dpf-lkml@fountainbay.com wrote:
> 
> > Ditching cryptoloop completely in 2.7 after dm-crypt 
> matures would be a
> > better idea.
> 
> Part of the reason for dropping cryptoloop is to help 
> dm-crypt mature more 
> quickly.
> 
> I've had some off-list email on the security of dm-crypt, and it seems
> that it does need some work.  We need to get the security 
> right more than 
> we need to worry about these other issues.
> 
> Let's drop the technically inferior of the two (cryptoloop) and
> concentrate on fixing the other (dm-crypt).
> 
> There was a thread on redesigning the security a while back (subject:
> "dm-crypt, new IV and standards"), but no code came out of 
> it.  Anyone 
> interested should probably have a look at that.
> 
> 
> - James
> -- 
> James Morris
> <jmorris@redhat.com>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

