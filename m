Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262067AbRETQEX>; Sun, 20 May 2001 12:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262069AbRETQEN>; Sun, 20 May 2001 12:04:13 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:19261 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S262067AbRETQEC>; Sun, 20 May 2001 12:04:02 -0400
Message-ID: <000901c0e146$4cb89760$3303a8c0@pnetz>
From: =?iso-8859-1?Q?Christian_Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: "szonyi calin" <caszonyi@yahoo.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20010520150945.66552.qmail@web13907.mail.yahoo.com>
Subject: Re: BUG ? and questions
Date: Sun, 20 May 2001 18:02:40 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a Cx 486/66 with 12 Megs of ram AST computer
> gcc 2.95.3, glibc 2.1.3, make 3.79.1 binutils 2.11 ??
> Problems:
> 1. When I try to run multiple (2) compilations on a
> 2.4.4 kernel usually one
> of them dies -- if it's gcc - signal 11 ,  if it's sh

looks like an out-of-memory (OOM) kill. Check your log files.
(var/log/messages but can vary on some distributions)
12 MB of RAM is not enough for Kernel 2.4.4 and several gcc runs, as some
gcc optimizations have complexity of O(n^2) or higher.

greetings

Christian Bornträger


