Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266938AbSL3Mko>; Mon, 30 Dec 2002 07:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266939AbSL3Mko>; Mon, 30 Dec 2002 07:40:44 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:56192
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266938AbSL3Mkn>; Mon, 30 Dec 2002 07:40:43 -0500
Subject: Re: holy grail
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Werner Almesberger <wa@almesberger.net>
Cc: Rik van Riel <riel@conectiva.com.br>,
       Anomalous Force <anomalous_force@yahoo.com>, ebiederm@xmission.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021229223247.C1363@almesberger.net>
References: <20021228163517.66372.qmail@web13207.mail.yahoo.com>
	<Pine.LNX.4.50L.0212281842020.26879-100000@imladris.surriel.com>
	<1041210304.1172.16.camel@irongate.swansea.linux.org.uk> 
	<20021229223247.C1363@almesberger.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Dec 2002 13:30:37 +0000
Message-Id: <1041255037.13076.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-30 at 01:32, Werner Almesberger wrote:
> Yes, but there are more applications than improving overall uptime.
> E.g. during development or other testing, it would be convenient to
> be able to switch back and forth between distinct kernels, without
> necessarily taking down the entire machine. Likewise for trivial
> hardware changes.

Suspend to disk
Change hardware
Resume

That much sort of works. An Intel guy wrote a very simple piece of code
I need to clean up into Linux format which rescans the pci bus and
generates insert/remove events for any device that took a walk.

Alan

