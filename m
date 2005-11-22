Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965096AbVKVSb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096AbVKVSb4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 13:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbVKVSb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 13:31:56 -0500
Received: from main.gmane.org ([80.91.229.2]:62938 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965096AbVKVSbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 13:31:55 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: Re: [RFC] Small PCI core patch
Date: Tue, 22 Nov 2005 19:26:55 +0100
Message-ID: <pan.2005.11.22.18.26.54.534251@free.fr>
References: <20051121225303.GA19212@kroah.com> <20051121230136.GB19212@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cac94-1-81-57-151-96.fbx.proxad.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le Mon, 21 Nov 2005 15:01:41 -0800, Greg KH a écrit :

> If you, or your company is relying on closed source kernel modules, your
> days are numbered.  And what are you going to do, and how are you going
> to explain things to your bosses and your customers, if possibly,
> something like this patch were to be accepted?
> 
Why not make a crappy GPL driver that just export again
the symbols ?

MODULE_LICENSE("GPL");

pci_bus_read_config_byte_binary (....)
{
pci_bus_read_config_byte(...)
}
EXPORT_SYMBOL(pci_bus_read_config_byte_binary);

[...]

Also why as an embeded company I can't remove the licence check in the
kernel I provide to my custommers.


No software tricks could force the company to use GPL because GPL allows
you to remove or short-cut these tricks.

Only the law can do something about softwares that don't comply to GPL
license...
It would be great if big companies that use Linux (OSDL, IBM, ...)
proposes a poll of lawyers which could do something like gpl-violations
(check if some softwares violate the GPL, if yes contact the copyright
holders, and if the developpers accept represent them).


Matthieu


