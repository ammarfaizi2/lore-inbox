Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289817AbSAKBHU>; Thu, 10 Jan 2002 20:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289818AbSAKBHK>; Thu, 10 Jan 2002 20:07:10 -0500
Received: from adsl-63-192-223-74.dsl.snfc21.pacbell.net ([63.192.223.74]:51504
	"EHLO gateway.berkeley.innomedia.com") by vger.kernel.org with ESMTP
	id <S289817AbSAKBGx>; Thu, 10 Jan 2002 20:06:53 -0500
Message-ID: <3C3E3AAB.749B1D51@berkeley.innomedia.com>
Date: Thu, 10 Jan 2002 17:06:51 -0800
From: Christopher James <cjames@berkeley.innomedia.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test1-rtl i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wright <chris@wirex.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Multicast fails when interface changed
In-Reply-To: <3C3C8D4D.621A4696@berkeley.innomedia.com> <20020109131013.C24733@figure1.int.wirex.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mangalore.zipworld.com.au id MAA18137

Chris Wright wrote:

> * Christopher James (cjames@berkeley.innomedia.com) wrote:
> > We are running an application that uses multicasting
> > on Linux kernel 2.2.19. The application is
> > connected to two network interfaces for redundancy
> > purposes - only one interface is active at a time.
> > When the application starts up on the first interface,
> > the application can send and receive multicast messages.
> > We then use ifconfig to bring down the first interface,
> > and use ifconfig to bring up the second interface. The application
> > works with the exception that it cannot receive multicast
> > packets (it can still send multicast packets).
>
> does your app use INADDR_ANY for imr_interface when you join the
> multicast group?
>
> -chris

the app (vocal 1.2) does not use INADDR_ANY for imr_interface when
joining the multicast group

-Christopher
ı:.Ë›±Êâmçë¢kaŠÉb²ßìzwm…ébïîË›±Êâmébìÿ‘êçz_âØ^n‡r¡ö¦zËëh™¨è­Ú&£ûàz¿äz¹Ş—ú+€Ê+zf£¢·hšˆ§~†­†Ûiÿÿïêÿ‘êçz_è®æj:+v‰¨ş)ß£ømšSåy«­æ¶…­†ÛiÿÿğÃí»è®å’i
