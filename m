Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264504AbTDPQns (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264505AbTDPQns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:43:48 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:35780
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264504AbTDPQnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:43:47 -0400
Subject: Re: 2.4.21-pre7 + Intel 82801AA IDE + 80Gb Barracuda do not work
	well together
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pau Aliagas <linuxnow@newtral.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0304161759290.4806-100000@pau.intranet.ct>
References: <Pine.LNX.4.44.0304161759290.4806-100000@pau.intranet.ct>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050508630.28727.134.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Apr 2003 16:57:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-16 at 17:15, Pau Aliagas wrote:
> I'm having serious trouble dealing with:
> * 80Gb Seagate Barracuda disc (Model Number ST380011A, Firmware Revision 3.04)
> * on an Intel 82801AA IDE controller

Thats a known to work configuration, so that is strange. Is the drive
known good and the driver/controller setup ok in "other OS" if you also
run it ?

> (RH-8.0 updated kernels) unless I boot with ide=nodma.
> With RH kernels it stalls reading the partition table.
> With 2.4.21-pre7 I get and error of the dma.

Same error in both cases, just its recovered properly in the newer code.


