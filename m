Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264822AbSKKMil>; Mon, 11 Nov 2002 07:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264974AbSKKMil>; Mon, 11 Nov 2002 07:38:41 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:31139 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264822AbSKKMik>; Mon, 11 Nov 2002 07:38:40 -0500
Subject: RE: random PID patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Heusden van, FJJ  " "(Folkert)" <F.J.J.Heusden@rn.rabobank.nl>
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <11D18E6D1073547-1319@_rabobank.nl_>
References: <11D18E6D1073547-1319@_rabobank.nl_>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Nov 2002 13:10:03 +0000
Message-Id: <1037020203.2919.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-11 at 10:12, Heusden van, FJJ (Folkert) wrote:
> Sometimes, (well; frequently) programs that create temporary
> files let the filename depend on their PID. A hacker could use
> that knowledge. So if you know that the application that

Still can if its random. The attacker can be the one who exec's the
vulnerable app. The attacker can use dnotify

> things it's not supposed to. Like forcing suid apps to create
> a file in the startup-scripts dir. or something.

Just use namespaces and give every login their own /tmp

