Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316798AbSGVLQO>; Mon, 22 Jul 2002 07:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316821AbSGVLQN>; Mon, 22 Jul 2002 07:16:13 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:9609 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S316798AbSGVLPY>; Mon, 22 Jul 2002 07:15:24 -0400
From: "BALBIR SINGH" <balbir.singh@wipro.com>
To: <martin@dalecki.de>, "'Christoph Hellwig'" <hch@lst.de>
Cc: "'Linus Torvalds'" <torvalds@transmeta.com>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] 2.5.27 sysctl
Date: Mon, 22 Jul 2002 16:51:52 +0530
Message-ID: <00e301c23171$fb122110$290806c0@wipro.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-c9ca57d7-f2a1-4709-a187-3e0c3178e339"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <3D3BE4C7.2060203@evision.ag>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-c9ca57d7-f2a1-4709-a187-3e0c3178e339
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

|-----Original Message-----
|From: linux-kernel-owner@vger.kernel.org 
|[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Marcin Dalecki
|Sent: Monday, July 22, 2002 4:26 PM
|To: Christoph Hellwig
|Cc: martin@dalecki.de; Linus Torvalds; Kernel Mailing List
|Subject: Re: [PATCH] 2.5.27 sysctl
|
|
|Christoph Hellwig wrote:
|> On Mon, Jul 22, 2002 at 12:42:07PM +0200, Marcin Dalecki wrote:
|> 
|>>This is making the sysctl code acutally be written in C.
|>>It wasn't mostly due to georgeous ommitted size array "forward 
|>>declarations". As a side effect it makes the table structure 
|easier to 
|>>deduce.
|> 
|> 
|> Please don't remove the trailing commas in the enums.  they make 
|> adding to them much easier and are allowed by gcc (and maybe 
|C99, I'm 
|> not sure).
|
|It's an GNU-ism. If you have any problem with "adding vales", 
|just invent some dummy end-value. I have a problem with using 
|-pedantic.

Its not, ANSI C allows a trailing comma.

Balbir


------=_NextPartTM-000-c9ca57d7-f2a1-4709-a187-3e0c3178e339
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

**************************Disclaimer************************************

Information contained in this E-MAIL being proprietary to Wipro Limited is 
'privileged' and 'confidential' and intended for use only by the individual
 or entity to which it is addressed. You are notified that any use, copying 
or dissemination of the information contained in the E-MAIL in any manner 
whatsoever is strictly prohibited.

***************************************************************************

------=_NextPartTM-000-c9ca57d7-f2a1-4709-a187-3e0c3178e339--
