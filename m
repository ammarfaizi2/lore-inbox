Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267298AbSLKUim>; Wed, 11 Dec 2002 15:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267300AbSLKUim>; Wed, 11 Dec 2002 15:38:42 -0500
Received: from pc2-cwma1-4-cust129.swan.cable.ntl.com ([213.105.254.129]:58051
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267298AbSLKUil>; Wed, 11 Dec 2002 15:38:41 -0500
Subject: Re: Bug Report 2.4.20: Interrupt sharing bogus
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <20021211212734.5429bfee.skraw@ithnet.com>
References: <20021211195501.7f6dff35.skraw@ithnet.com>
	<1039635955.18587.12.camel@irongate.swansea.linux.org.uk>
	<20021211203403.130fc724.skraw@ithnet.com>
	<1039639993.18587.19.camel@irongate.swansea.linux.org.uk> 
	<20021211212734.5429bfee.skraw@ithnet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Dec 2002 21:23:54 +0000
Message-Id: <1039641834.18587.33.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-11 at 20:27, Stephan von Krawczynski wrote:
> Why does it freeze then with this config? I doubt it has ultimately to do with
> the 4-port card being of "4-port nature". I can use every of its ports that

four port cards tend to test two things. PCI bridging and also IRQ
routing since they tend to use INTA-D not just INTA as is normal.

> does not share interrupt with another device. As soon as I share I get busted.
> As I told the driver used for ethernet doesn't seem to matter as tulip and
> sundance show the same effect.
> I am very interested in solving this somehow having five pieces of these
> boards...

I would be very interested if (and I've seen this before with other
vendors boards) plugging the quad card into a good old intel 440BX or
something like that makes them work.


