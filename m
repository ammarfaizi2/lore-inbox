Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263966AbTH1JDM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 05:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263965AbTH1JDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 05:03:11 -0400
Received: from mail.medav.de ([213.95.12.190]:18827 "EHLO mail.medav.de")
	by vger.kernel.org with ESMTP id S263966AbTH1JDI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 05:03:08 -0400
From: "Daniela Engert" <dani@ngrt.de>
To: "Kathy Frazier" <kfrazier@mdc-dayton.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Thu, 28 Aug 2003 11:02:43 +0200 (CDT)
Reply-To: "Daniela Engert" <dani@ngrt.de>
X-Mailer: PMMail 2.00.1500 for OS/2 Warp 4.05
In-Reply-To: <PMEMILJKPKGMMELCJCIGEEDNCEAA.kfrazier@mdc-dayton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Re: Linux and PCI bridge
Message-Id: <20030828090209.E6FFC2823B@mail.medav.de>
X-AntiVirus: OK! AntiVir MailGate Version 2.0.1.1; AVE: 6.21.0.1; VDF: 6.21.0.29
	 at mail has not found any known virus in this email.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Aug 2003 09:51:21 -0500, Kathy Frazier wrote:

>- Can anyone recommend any tools that would be useful in debugging this?
>I've started looking at a couple of PCI bus analyzers, but I'm not sure that
>it will allow me to detect anything with respect to the bridge or the FSB.

In the past couple of years, probably the most valuable asset in
developping both the hardware and the software of our PCI boards has
been the VMetro PCI bus analyzer/excerciser. The analyzer allows us to
watch and trace all PCI signals/cycles in real time, while the
excerciser gives us the capability to probe/drive all mem/io/config
address ranges which are visible from the bus which the bus analyzer
board is sitting on. This excludes everything beyond the PCI bus domain
unless you are able to hook an additional signal to one of the general
purpose trace inputs.

In fact, I'd never ever develop a driver for whichever OS you like
without such a tool - it spoils you ;-) As it turned out, it's even
more valuable in software development than hardware development.

Ciao,
  Dani

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Daniela Engert, systems engineer at MEDAV GmbH
Gräfenberger Str. 32-34, 91080 Uttenreuth, Germany
Phone ++49-9131-583-348, Fax ++49-9131-583-11


