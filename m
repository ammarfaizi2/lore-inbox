Return-Path: <linux-kernel-owner+w=401wt.eu-S1161119AbXAEPv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161119AbXAEPv2 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 10:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161136AbXAEPv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 10:51:28 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:36982 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161119AbXAEPv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 10:51:28 -0500
X-Sasl-enc: zKseY3jUA0iUEANrKirTh/qj1hRW3geyBd3T+5vm0amD 1168012118
Date: Fri, 5 Jan 2007 13:51:19 -0200
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Jiri Kosina <jikos@jikos.cz>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
       Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
       linux-acpi@intel.com, linux-kernel@vger.kernel.org
Subject: Re: ACPI bay - 2.6.20-rc3-mm1 hangs on boot
Message-ID: <20070105155119.GA6804@khazad-dum.debian.net>
References: <Pine.LNX.4.64.0701051351200.16747@twin.jikos.cz> <20070105143356.GA29782@khazad-dum.debian.net> <Pine.LNX.4.64.0701051610540.16747@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701051610540.16747@twin.jikos.cz>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Jan 2007, Jiri Kosina wrote:
> On Fri, 5 Jan 2007, Henrique de Moraes Holschuh wrote:
> > > 2.6.20-rc3-mm1 hangs on boot on my IBM T42p when compiled with ACPI_BAY=y. 
> > I trust you have ACPI_IBM_BAY=n to use ACPI_BAY=y ?  I don't think it has
> > anything to do with the issue you have, but just in case...
> 
> The kernel hangs with CONFIG_ACPI_BAY, with CONFIG_ACPI_IBM_BAY it works 
> just fine.

I mean don't do it with both CONFIG_ACPI_BAY and CONFIG_ACPI_IBM_BAY set to
y (i.e. loaded at the same time).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
