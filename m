Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLOS7l>; Fri, 15 Dec 2000 13:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129340AbQLOS7X>; Fri, 15 Dec 2000 13:59:23 -0500
Received: from adsl-63-194-20-32.dsl.lsan03.pacbell.net ([63.194.20.32]:40964
	"EHLO symonds.net") by vger.kernel.org with ESMTP
	id <S129228AbQLOS7C>; Fri, 15 Dec 2000 13:59:02 -0500
Message-ID: <003001c066c5$0cab0960$0301a8c0@symonds.net>
From: "Mark Symonds" <mark@symonds.net>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
In-Reply-To: <E146V8k-00043W-00@the-village.bc.nu>
Subject: Re: VM problems still in 2.2.18
Date: Fri, 15 Dec 2000 10:30:06 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: "Mark Symonds" <mark@symonds.net>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, December 14, 2000 1:57 AM
Subject: Re: VM problems still in 2.2.18


Hihi,

>> Box A will randomly lock without 
>> warning and box B will die and start printing this message 
>> repeatedly on the screen until I physically hit reset:
>
>What are these two boxes doing ?

One is a P233 32MB and the other is a P100 24MB.  We do 
run *alot* of different things on it and the load has
grown substantially since the switch from 2.2.14.  For
example one of the web developers did a webmail which uses
php-mysql so we have apache-ssl's and mysqld's sitting
there, then there is the guy who likes jserv, then the 
mailserver (around 2000 a day) etc. etc.

> Andrea's VM-global patch seems to be a wonder cure for 
> those who have tried it. Give it a shot and let folks know.

OK, will do.  Just booted the new patched kernel about 
five minutes ago so should know before the end of the 
weekend if that does it.  

Thanks much.  :)

--
Mark

grep me no patterns and I'll tell you no lines.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
