Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272044AbTG2TOE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 15:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272045AbTG2TOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 15:14:04 -0400
Received: from fep04-mail.bloor.is.net.cable.rogers.com ([66.185.86.74]:59927
	"EHLO fep04-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S272044AbTG2TN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 15:13:57 -0400
Message-ID: <18fc01c35605$ccad23b0$7f0a0a0a@lappy7>
Reply-To: "Sean Estabrooks" <seanlkml@rogers.com>
From: "Sean Estabrooks" <seanlkml@rogers.com>
To: "Mikael Pettersson" <mikpe@csd.uu.se>
Cc: <linux-kernel@vger.kernel.org>
References: <200307291734.h6THYhmp012585@harpo.it.uu.se>
Subject: Re: [BUG] 2.6.0-test2 loses time on 486
Date: Tue, 29 Jul 2003 15:15:40 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep04-mail.bloor.is.net.cable.rogers.com from [24.102.213.108] using ID <seanlkml@rogers.com> at Tue, 29 Jul 2003 15:13:13 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My old 486 test box is losing time at an alarming rate

try changing the line in  "include/asm-i386/param.h":

# define HZ             1000  

to

# define HZ             100

and see if the problem remains after recompiling.

Regards,
Sean

