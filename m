Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261370AbSKWL0Z>; Sat, 23 Nov 2002 06:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbSKWL0Z>; Sat, 23 Nov 2002 06:26:25 -0500
Received: from ns.ithnet.com ([217.64.64.10]:11782 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S261370AbSKWL0Y>;
	Sat, 23 Nov 2002 06:26:24 -0500
Date: Sat, 23 Nov 2002 12:33:22 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Hard Lockup with 2.4.20-rc3 and ISDN (ippp)
Message-Id: <20021123123322.3e6ef7c2.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.44L.0211221520230.22247-100000@freak.distro.conectiva>
References: <Pine.LNX.4.44L.0211221520230.22247-100000@freak.distro.conectiva>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2002 15:21:28 -0200 (BRST)
Marcelo Tosatti <marcelo@conectiva.com.br> wrote:

> 
> Hi,
> 
> Finally, here goes -rc3.
> [...]
> Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
>   o ISDN: Fix error path in isdn_ppp.c

Something must be wrong with this one, I experience an immediate hard lockup
when trying to use a ippp-connection. No way around it, always happens. And no
panic message or anything, just complete immediate lockup. This is with hisax +
AVM Fritz PCI 2.0 + SMP + SuSE 8.1 distro installation.
Anybody else with the same problem?
rc2 works for _some_ connections (after a while I have to reload the drivers to
work again). All 20pre version work without any problem at all.

Regards,
Stephan
