Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263143AbSLFPnI>; Fri, 6 Dec 2002 10:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263188AbSLFPnI>; Fri, 6 Dec 2002 10:43:08 -0500
Received: from herrmann.cherheim.etc.tu-bs.de ([134.169.163.222]:51214 "EHLO
	herrmann.priv.cher.sinus.tu-bs.de") by vger.kernel.org with ESMTP
	id <S263143AbSLFPnH>; Fri, 6 Dec 2002 10:43:07 -0500
Content-Type: text/plain; charset=US-ASCII
From: Felix Maibaum <f.maibaum@tu-bs.de>
To: Torben Mathiasen <torben.mathiasen@hp.com>
Subject: Re: 2.4.20 locks up after ide init on tyan s2460
Date: Fri, 6 Dec 2002 16:50:32 +0100
User-Agent: KMail/1.4.3
References: <200212051655.43554.f.maibaum@tu-bs.de> <20021205123251.GM1252@tmathiasen>
In-Reply-To: <20021205123251.GM1252@tmathiasen>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212061650.32819.f.maibaum@tu-bs.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 5. Dezember 2002 13:32 schrieben Sie:
> Does it work if you boot with 'ide=nodma' ?

no, the only difference ist that I don't get that message anymore, but the 
system still halts. It happens right after the controllers are detected:

ide0 at someaddress on someirq
ide1 at someaddress on someirq
ide2 at someaddress on someirq
ide3 at someaddress on someirq

and before the harddisks attached to these controllers should be detected.


> Also please provide your dmesg output.

gladly, but it is of course from 2.4.19, as I am unable to run 2.4.20.

it's at 

http://www.tu-bs.de/~y0013531/dmesg.txt

any other ideas?

Felix



