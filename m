Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281855AbRK1BlD>; Tue, 27 Nov 2001 20:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281854AbRK1Bkx>; Tue, 27 Nov 2001 20:40:53 -0500
Received: from pd17.jeleniag.cvx.ppp.tpnet.pl ([213.77.236.17]:20996 "HELO
	marek.almaran.home") by vger.kernel.org with SMTP
	id <S281852AbRK1Bkp> convert rfc822-to-8bit; Tue, 27 Nov 2001 20:40:45 -0500
Subject: Re: 2.4.16, 8139too not loadable as a module - unresolved symbols
From: Marek =?iso-8859-13?Q?P=E6tlicki?= <marpet@linuxpl.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20011127150800.A25438@torres.ka0.zugschlus.de>
In-Reply-To: <20011127150800.A25438@torres.ka0.zugschlus.de>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 28 Nov 2001 00:31:15 +0100
Message-Id: <1006903886.1285.2.camel@marek.almaran.home>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

W li¶cie z wto, 27-11-2001, godz. 15:08, Marc Haber pisze: 
> 
> Hi,
> 
> on my only 2.4.16 system, modprobe 8139too gives the following errors:
[...]
> The same kernel, with the only config change being "y" instead of "m"
> for 8139too, works fine, and the network interface is useable.
> 
> Did I do something wrong?

maybe you did, works fine for me as a module, although this driver
doesn't want to compile with gcc 3.0.x (as said in another thread a few
days ago).

did you do the _full_ recompile of the kernel? (cp .config /tmp;make
mrproper;cp /tmp/.config .;make oldconfig dep install modules_install)
or did you just make modules modules_install after changing the config?

regards

-- 
Marek Pêtlicki <marpet@linuxpl.org>
Linux User ID=162988


