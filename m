Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271461AbTGQO0W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 10:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271462AbTGQO0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 10:26:22 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:13007
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S271461AbTGQO0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 10:26:19 -0400
Subject: Re: 2.6.0-test1-ac2 issues / Toshiba Laptop keyboard
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030717141847.GF7864@charite.de>
References: <20030717141847.GF7864@charite.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058452714.9048.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Jul 2003 15:38:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-07-17 at 15:18, Ralf Hildebrandt wrote:
> Finally, I was able to get 2.6.0-test1-ac2 working.
> 
> Some issues I found:
> 
> * eepro100 is b0rked:
> 
> eepro100: Unknown symbol mii_ethtool_sset
> eepro100: Unknown symbol mii_link_ok
> eepro100: Unknown symbol mii_check_link
> eepro100: Unknown symbol mii_nway_restart
> eepro100: Unknown symbol mii_ethtool_gset

You must load mii as well. The module tools should be doing that if
you are using modprobe

> * The kernel reports itself as "Linux version 2.6.0-test1-ac1" but IS
>   ac2!

Yep

> * The IDE ATA disk works, but upon reboot, the machine does NOT find
>   the IDE harddisk anymore! Tis means I have to turn the machine off
>   and on again (since it has no reset button)

Curious. Could be the BIOS doesn't know how to do hard disk power
management especially if its quite an old PC 

