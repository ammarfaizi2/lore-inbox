Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267308AbSLKVkv>; Wed, 11 Dec 2002 16:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267312AbSLKVku>; Wed, 11 Dec 2002 16:40:50 -0500
Received: from WebDev.iNES.RO ([80.86.100.174]:16012 "HELO webdev.ines.ro")
	by vger.kernel.org with SMTP id <S267308AbSLKVku>;
	Wed, 11 Dec 2002 16:40:50 -0500
Date: Wed, 11 Dec 2002 23:48:36 +0200 (EET)
From: Andrei Ivanov <andrei.ivanov@ines.ro>
X-X-Sender: shadow@webdev.ines.ro
To: Robert Love <rml@tech9.net>
cc: procps-list@redhat.com, "" <linux-kernel@vger.kernel.org>,
       "" <riel@conectiva.com.br>
Subject: Re: [announce] procps 2.0.11
In-Reply-To: <1039639829.826.119.camel@phantasy>
Message-ID: <Pine.LNX.4.50L0.0212112343550.6387-100000@webdev.ines.ro>
References: <1039639829.826.119.camel@phantasy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


top reports this:

7 root 18446744073709551615 -20 0 0 0 SW< 0.0  0.0   A0:00   0 mdrecoveryd
8 root 18446744073709551615 -20 0 0 0 SW< 0.0  0.0   0:00   0 raid1d

is this strange or what ?

ps aux says:

root  7  0.0  0.0  0  0 ?  SW<  Dec09   0:00 [mdrecoveryd]
root  8  0.0  0.0  0  0 ?  SW<  Dec09   0:00 [raid1d]

(both from 2.0.11)

kernel 2.4.20-pre6
