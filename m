Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291214AbSAaSFF>; Thu, 31 Jan 2002 13:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291213AbSAaSEr>; Thu, 31 Jan 2002 13:04:47 -0500
Received: from courriel.ift.ulaval.ca ([132.203.26.4]:25360 "EHLO
	courriel.ift.ulaval.ca") by vger.kernel.org with ESMTP
	id <S291211AbSAaSEj>; Thu, 31 Jan 2002 13:04:39 -0500
To: Robert Love <rml@tech9.net>
Subject: Re: [PATCH] 2.5: further llseek cleanup (3/3)
Message-ID: <1012500123.3c59869bbbff0@courriel.ift.ulaval.ca>
Date: Thu, 31 Jan 2002 13:02:03 -0500
From: Guillaume Chamberland-Larose 
	<Guillaume.Chamberland-Larose@ift.ulaval.ca>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <1012497140.3219.163.camel@phantasy>
In-Reply-To: <1012497140.3219.163.camel@phantasy>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
User-Agent: IMP/PHP IMAP webmail program 
X-Originating-IP: 132.203.26.102
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was reading through your patch and got confused: shouldn't you call 
unlock_kernel() before you return( ret ) 
in linux-2.5.3/arch/cris/drivers/eeprom.c

Just my 0.02$

Guills

-------------------------------------------------
Ce message a été envoyé par le serveur IMP du département d'informatique à l'université Laval: courriel.ift.ulaval.ca
