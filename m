Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262373AbSL3ABN>; Sun, 29 Dec 2002 19:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262380AbSL3ABN>; Sun, 29 Dec 2002 19:01:13 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:9344
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262373AbSL3ABM>; Sun, 29 Dec 2002 19:01:12 -0500
Subject: Re: [PATCH] Workaround for AMD762MPX "mouse" bug
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Balazic <david.balazic@uni-mb.si>
Cc: ak@muc.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E0F0AE1.EB2C5DAA@uni-mb.si>
References: <3E0F0AE1.EB2C5DAA@uni-mb.si>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Dec 2002 00:50:07 +0000
Message-Id: <1041209407.1172.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-12-29 at 14:46, David Balazic wrote:
> Just connecting a PS/2 mouse on a running system does not help, right ?
> :-)

It has to occur at boot. The fix proposed is crap though. Its perfectly
possible to reserve the page at boot up time and give it back later if
the errata is not found and it isnt in the EBDA.


