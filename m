Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbTEHWcj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 18:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbTEHWcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 18:32:39 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:54665
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262185AbTEHWci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 18:32:38 -0400
Subject: Re: The magical mystical changing ethernet interface order
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jt@hpl.hp.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <20030508193245.GA26721@bougret.hpl.hp.com>
References: <20030508193245.GA26721@bougret.hpl.hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052430385.13567.17.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 May 2003 22:46:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-05-08 at 20:32, Jean Tourrilhes wrote:
> 	My belief is that configuration scripts should be specified in
> term of MAC address (or subset) and not in term of device name. Just
> like the Pcmcia scripts are doing it.
> 	And let's go the extra mile : ifconfig should accept a MAC
> address as the argument instead of a device name. And in the long
> term, just get rid of device name from the user view.

Current Red Hat supports naming interfaces by their mac address. That
keeps most people happy except some sparc and embedded users who have
one mac per host not per card (and yes that *is* allowed by the
802.x spec)

