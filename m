Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271783AbRIEHJy>; Wed, 5 Sep 2001 03:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271784AbRIEHJo>; Wed, 5 Sep 2001 03:09:44 -0400
Received: from mail.webmaster.com ([216.152.64.131]:58522 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S271783AbRIEHJb>; Wed, 5 Sep 2001 03:09:31 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Aaron Lehmann" <aaronl@vitelus.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.9-ac6
Date: Wed, 5 Sep 2001 00:09:49 -0700
Message-ID: <NOEJJDACGOHCKNCOGFOMGEBNDLAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
In-Reply-To: <NOEJJDACGOHCKNCOGFOMMEBMDLAA.davids@webmaster.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 	I think, perhaps, the logic should be that a module
> shouldn't taint the kernel if:
>
> 	1) The user built the module from source on that machine, OR
>
> 	2) The module source is freely available without restriction

	I just realized two things. One, there's a strong argument that this should
be an AND, not an OR. Second, even if the code is freely available, it might
have been locally modified and the local modifications may not be easily
available (this can happen even if the code is GPL'd since source
distribution is only required if the compiled code is distributed). So the
stamping of the module source as freely available would have to have a
checksum or something like that. (Unless this is officially deemed to be No
Big Deal.)

	DS

