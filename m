Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292217AbSBTTPH>; Wed, 20 Feb 2002 14:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292223AbSBTTOs>; Wed, 20 Feb 2002 14:14:48 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:44302 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S292217AbSBTTO3>;
	Wed, 20 Feb 2002 14:14:29 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200202201913.WAA10379@ms2.inr.ac.ru>
Subject: Re: Moving fasync_struct into struct file?
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Wed, 20 Feb 2002 22:13:28 +0300 (MSK)
Cc: alan@lxorguk.ukuu.org.uk, rusty@rustcorp.com.au, davem@redhat.com,
        sfr@canb.auug.org.au, linux-kernel@vger.kernel.org
In-Reply-To: <E16dM74-0002Do-00@the-village.bc.nu> from "Alan Cox" at Feb 20, 2 02:04:06 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Then fix your driver. All the drivers I looked at do stuff like this...
> which seems to do the job nicely

But this code is even not reached in the case which Paul tells about.

It should be executed earlier, as you noticed.

Alexey
