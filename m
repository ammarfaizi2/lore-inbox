Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261452AbTCONfQ>; Sat, 15 Mar 2003 08:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261453AbTCONfQ>; Sat, 15 Mar 2003 08:35:16 -0500
Received: from smtp1.wanadoo.fr ([193.252.22.25]:8460 "EHLO
	mwinf0603.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S261452AbTCONfQ>; Sat, 15 Mar 2003 08:35:16 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: Karl Vogel <karl.vogel@seagha.com>, linux-kernel@vger.kernel.org
Subject: Re: v2.5.32 - v2.5.64+ Locks at Boot with Athlon Machine
Date: Sat, 15 Mar 2003 14:45:57 +0100
User-Agent: KMail/1.5
References: <5.1.0.14.0.20030312104635.022b1178@shrek> <E18tnzg-0007Zf-00@relay-1.seagha.com>
In-Reply-To: <E18tnzg-0007Zf-00@relay-1.seagha.com>
Cc: Jim Peterson <jpeterson@annapmicro.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303151445.57486.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did you turn on console support in your .config?
	CONFIG_VT=y
	CONFIG_VT_CONSOLE=y
You will need to compile input support into the kernel (i.e. not as a module):
	CONFIG_INPUT=y
I hope this helps,

Duncan.
