Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbTDDVsp (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 16:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbTDDVsp (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 16:48:45 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:19596
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261382AbTDDVso (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 16:48:44 -0500
Subject: Re: Linux 2.4.21-pre7
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030404213441.GA4730@werewolf.able.es>
References: <Pine.LNX.4.53L.0304041815110.32674@freak.distro.conectiva>
	 <20030404213441.GA4730@werewolf.able.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049490101.2150.89.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Apr 2003 22:01:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-04-04 at 22:34, J.A. Magallon wrote:
> On 04.04, Marcelo Tosatti wrote:
> > 
> > So here goes -pre7. Hopefully the last -pre.
> > 
> > Alan Cox <alan@lxorguk.ukuu.org.uk>:
> >   o PCI layer bits for 440GX
> 
> Any pointer for info on this ?

The changes to arch/i386/kernel/pci and dmi_scan.c should be
fairly self explanatory. We muse use BIOS routing not $PIR
routing

