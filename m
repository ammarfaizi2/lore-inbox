Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289482AbSBSTSM>; Tue, 19 Feb 2002 14:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289328AbSBSTSC>; Tue, 19 Feb 2002 14:18:02 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:33796 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S289054AbSBSTRr>;
	Tue, 19 Feb 2002 14:17:47 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200202191917.WAA28452@ms2.inr.ac.ru>
Subject: Re: Moving fasync_struct into struct file?
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 19 Feb 2002 22:17:11 +0300 (MSK)
Cc: rusty@rustcorp.com.au, davem@redhat.com, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org
In-Reply-To: <E16d6JQ-0008LI-00@the-village.bc.nu> from "Alan Cox" at Feb 19, 2 09:11:48 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> We already clean up fasync structures on close,

We do not.


> responsibility to do so.  If you wanted to be more strict you could do
> a similar helper call in the other closing callback for each fd close.

This is technical issue how to implement this exactly.

BTW, sed -e 's/more strict/not so buggy/' :-)

Alexey
