Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137134AbREKN17>; Fri, 11 May 2001 09:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137135AbREKN1u>; Fri, 11 May 2001 09:27:50 -0400
Received: from oe73.law11.hotmail.com ([64.4.16.208]:19972 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S137134AbREKN1e>;
	Fri, 11 May 2001 09:27:34 -0400
X-Originating-IP: [12.19.166.64]
From: "Dan Mann" <daniel_b_mann@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: 3c590 vs. tulip
Date: Fri, 11 May 2001 09:27:29 -0400
MIME-Version: 1.0
Content-Type: text/plain;	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Message-ID: <OE73aZbF27y4RbrxUrO000014d0@hotmail.com>
X-OriginalArrivalTime: 11 May 2001 13:27:28.0375 (UTC) FILETIME=[1FCC9870:01C0DA1E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was just wondering if anybody had an idea which nic card might be a better
choice for me; I have a pci 3c590 and a pci smc that uses the tulip driver.
I don't have the card number for the smc with me handy, however I know both
cards were manufactured in 1995.  Is either card/driver a better choice for
a mildly used file server (I am running 2.4.4 Linus)?


Question 2:

Also, I've got another linux box that is connecting to the server as a
client.  Machines are using samba to share files.  Both machines are running
Hybrid Debian 2.2 + unstable, with 2.4.4 Linus kernel. Server is a P75, 32MB
of ram, 1 8GB ide drive and the above mentioned smc nic with tulip driver.
Client is PII233, 196MB Ram, 1 6GB ide drive and another of the above
mentioned nic cards (smc, tulip).

The server has lots (ok, about 20,000 not counting the os itself) of medium
sized files on it, ranging in size from 60k to 40MB.  When I run gqview
(image viewing program) on the client and point to a local directory that is
mapped to the server using samba, the images (over 4000 in one directory)
are displayed absolutely as fast as I can click my mouse button.  No lag
time whatsoever.  How can this be so fast?  Even with the images on my local
faster machine it is much slower.  Images take at least .5 to 1 second to
load when they are stored locally.  But over the network, with 2.4.4 and
samba 2.2, It's as if the server "knows" what I'm going to ask for before I
actually do.  Is this normal?  I honestly don't think it was this fast when
server was on 2.2 Kernel with samba 2.07.

Maybe it is just me, but it seems much faster.

Dan

