Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbTCBVXk>; Sun, 2 Mar 2003 16:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbTCBVXk>; Sun, 2 Mar 2003 16:23:40 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:48025
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261368AbTCBVXk>; Sun, 2 Mar 2003 16:23:40 -0500
Subject: Re: 2.5.63: 'Debug: sleeping function called from illegal context
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <3E62200D.2010505@colorfullife.com>
References: <3E62200D.2010505@colorfullife.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046644666.3698.35.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 02 Mar 2003 22:37:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-02 at 15:15, Manfred Spraul wrote:
> I would propose something like the attached patch - it handles all archs 
> that support disable_irq on an unregistered interrupt. The remaining 
> arch [which one, btw] must implement request_irq_disabled().


Some m68k at least and possibly others. 

