Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264634AbTFTUpa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 16:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264635AbTFTUpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 16:45:30 -0400
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:60233 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264634AbTFTUp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 16:45:28 -0400
Reply-To: <benoit.beauchamp@sbcglobal.net>
From: "Benoit Beauchamp" <benoit.beauchamp@sbcglobal.net>
To: "'Sam Ravnborg'" <sam@ravnborg.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: 2.5.72 fixdep / cant make *config
Date: Fri, 20 Jun 2003 13:59:17 -0700
Organization: lightx.org
Message-ID: <001d01c3376e$d0951fb0$0201a8c0@WIRE>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <20030620204729.GA16354@mars.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

root@high:/usr/src# echo $LANG
C

_________________________________________

Benoit Beauchamp

> -----Original Message-----
> From: Sam Ravnborg [mailto:sam@ravnborg.org] 
> Sent: June 20, 2003 1:47 PM
> To: Benoit Beauchamp
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: 2.5.72 fixdep / cant make *config
> 
> 
> On Fri, Jun 20, 2003 at 12:38:04PM -0700, Benoit Beauchamp wrote:
> >   HOSTCC  scripts/fixdep
> > In file included from /usr/include/netinet/in.h:212,
> >                  from scripts/fixdep.c:107:
> > /usr/include/bits/socket.h:305:24: asm/socket.h: No such file or 
> > directory
> > scripts/fixdep.c: In function `use_config':
> 
> What is LANG set to?
> Try:
> $ echo $LANG
> 
> Evantually try:
> LANG=C; make
> 
> With some installations gcc gets confused, and cannot locate 
> the include files.
> 
> 	Sam
> 


