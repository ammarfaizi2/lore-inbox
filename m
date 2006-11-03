Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752991AbWKCCrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991AbWKCCrf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 21:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752993AbWKCCrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 21:47:35 -0500
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:13951 "HELO
	smtp105.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752990AbWKCCre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 21:47:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=lDT6wneZv4rf3et/B7vMuGvLWNxkKJFT1HWLFbatD8xJGIh8AyvKE7GEN5XGAtSA3aLDsuek8fjG90C2FISKizOIgkAW3iP26Jn5gHCDXcDzlV1r97PyTiOBEoFJtiyUHPBzYtiyjxdpvrFdaCBJDDzVVEcY/OhOwTIZTecVXU0=  ;
From: David Brownell <david-b@pacbell.net>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH 2/2] usbnet: use MII hooks only if CONFIG_MII is enabled
Date: Thu, 2 Nov 2006 18:47:15 -0800
User-Agent: KMail/1.7.1
Cc: Greg KH <greg@kroah.com>, Randy Dunlap <randy.dunlap@oracle.com>,
       toralf.foerster@gmx.de, netdev@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, link@miggy.org, akpm@osdl.org,
       zippel@linux-m68k.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org> <200611021229.17324.david-b@pacbell.net> <20061103022726.GF13381@stusta.de>
In-Reply-To: <20061103022726.GF13381@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611021847.21817.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 November 2006 6:27 pm, Adrian Bunk wrote:

> It seems to lack the "select MII" at the USB_RTL8150 option that was in 
> Randy's first patch?

I was just addressing the usbnet issues ... that driver doesn't
use the usbnet framework.

- Dave
