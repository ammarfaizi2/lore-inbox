Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbSKCEk0>; Sat, 2 Nov 2002 23:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261627AbSKCEk0>; Sat, 2 Nov 2002 23:40:26 -0500
Received: from air-2.osdl.org ([65.172.181.6]:26337 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261615AbSKCEkZ> convert rfc822-to-8bit;
	Sat, 2 Nov 2002 23:40:25 -0500
Date: Sat, 2 Nov 2002 20:42:46 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "J.A. =?ISO-8859-1?Q?Magall=F3n?=" <jamagallon@able.es>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kconfig (qt) -> Gconfig (gtk)
In-Reply-To: <1036287009.18289.5.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33L2.0211022041080.32677-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Nov 2002, Alan Cox wrote:

| On Sun, 2002-11-03 at 00:06, J.A. Magallón wrote:
| > As I see it, the onle thing that should be included in a standard kernel
| > would be something like a kconfig-xaw, that is sure to be on every box that
| > has X, and could be a reference implementation.
|
| Lots of people no longer include Xaw either nowdays 8)
|
| Probably the easiest way to do this would be to move the GUI tools out
| of the kernel (or maybe leave the common useful ones) and have make
| guiconfig do
|
| 	if [ -f /usr/sbin/kernel-gui-config ] ; then
| 		/usr/sbin/kernel-gui-config
| 	elif got_qt() ; then
| 		qt config
| 	elif got_gtk() ; then
| 		gtk_config
| 	else
| 		warnign message
| 		make config
		make menuconfig || make oldconfig || make config
| 	fi
| -

Please don't stick us with 'make config'.  :)

-- 
~Randy

