Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263314AbTCNOHf>; Fri, 14 Mar 2003 09:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263317AbTCNOHf>; Fri, 14 Mar 2003 09:07:35 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:6611
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263314AbTCNOHe>; Fri, 14 Mar 2003 09:07:34 -0500
Subject: Re: dpt_i2o.c fix for possibly memory corruption on reset timeout
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: Joern Engel <joern@wohnheim.fh-wedel.de>,
       vda@port.imtp.ilyichevsk.odessa.ua, "Randy.Dunlap" <rddunlap@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       deanna_bonds@adaptec.com
In-Reply-To: <20030314134328.GA8804@linuxhacker.ru>
References: <20030313182819.GA2213@linuxhacker.ru>
	 <20030313105125.1548d67c.rddunlap@osdl.org>
	 <20030313185628.GA2485@linuxhacker.ru>
	 <200303140921.h2E9Lqu08107@Port.imtp.ilyichevsk.odessa.ua>
	 <1047651597.27700.1.camel@irongate.swansea.linux.org.uk>
	 <20030314133942.GA23062@wohnheim.fh-wedel.de>
	 <20030314134328.GA8804@linuxhacker.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047655600.29544.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 14 Mar 2003 15:26:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-14 at 13:43, Oleg Drokin wrote:
> Well, if some hardware would do so, then users would go here and complain
> about kernel being noisy on certain hardware. (message is printed each
> time this happens). Have not happened so far.

Its run once per controller on board setup, and if it fails that controller
is history until reboot

