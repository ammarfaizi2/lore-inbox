Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262946AbTDYSsh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 14:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263635AbTDYSsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 14:48:37 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:2699
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262946AbTDYSsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 14:48:36 -0400
Subject: Re: problem with Serverworks CSB5 IDE
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Duncan Laurie <duncan@sun.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3EA983F3.2000306@sun.com>
References: <3EA85C5C.7060402@sun.com> <20030423212713.GD21689@puck.ch>
	 <1051136469.2062.108.camel@dhcp22.swansea.linux.org.uk>
	 <20030423232909.GE21689@puck.ch> <20030423232909.GE21689@puck.ch>
	 <20030424080023.GG21689@puck.ch> <3EA85C5C.7060402@sun.com>
	 <1051268422.5573.25.camel@dhcp22.swansea.linux.org.uk>
	 <3EA964D1.3070908@sun.com>
	 <1051285350.5902.14.camel@dhcp22.swansea.linux.org.uk>
	 <3EA983F3.2000306@sun.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051293721.6642.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 Apr 2003 19:02:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-04-25 at 19:52, Duncan Laurie wrote:
> It might just be another unfortunate serverworks chipset bug...
> 
> The CSB5 doesn't appear to fully support native mode--sure you can
> put it in native mode (!) and you're free to assign the BARs any
> way you want, but it still assumes IRQ14 for ide0 and IRQ15 for
> ide1 when they should really be collapsed and shared on a single
> PCI (non-compatibility) interrupt.

Could be. I've never seen one in native mode. 


