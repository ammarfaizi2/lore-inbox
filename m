Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267775AbTBGJz3>; Fri, 7 Feb 2003 04:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267776AbTBGJz3>; Fri, 7 Feb 2003 04:55:29 -0500
Received: from matrix.roma2.infn.it ([141.108.255.2]:60305 "EHLO
	matrix.roma2.infn.it") by vger.kernel.org with ESMTP
	id <S267775AbTBGJz1>; Fri, 7 Feb 2003 04:55:27 -0500
Message-ID: <40163.141.108.16.102.1044612299.squirrel@webmail.roma2.infn.it>
Date: Fri, 7 Feb 2003 11:04:59 +0100 (CET)
Subject: Re: zero copy
From: "Emiliano Gabrielli" <emiliano.gabrielli@roma2.infn.it>
To: <linux-kernel@vger.kernel.org>, <kernelnewbies@nl.linux.org>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
X-Mailer: SquirrelMail (version 1.2.7)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



<quote who="Venkat Raghu">
>
>
> Hi,
>
> What is zero copy mechanism in ethernet drivers.
>
> Regards
> Venkat

Zero copy is intended to bypass the need of copying the user space buffer in kernel
space via copy_from_user.

It is achieved by mapping dma buffer in user space for exaple so that eth driver can
directly use them for dma

-- 
Emiliano Gabrielli

dip. di Fisica
2° Università di Roma "Tor Vergata"


-- 
Emiliano Gabrielli

dip. di Fisica
2° Università di Roma "Tor Vergata"


