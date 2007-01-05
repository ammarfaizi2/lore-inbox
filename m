Return-Path: <linux-kernel-owner+w=401wt.eu-S1161129AbXAEPNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161129AbXAEPNj (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 10:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161134AbXAEPNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 10:13:39 -0500
Received: from twin.jikos.cz ([213.151.79.26]:44651 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161129AbXAEPNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 10:13:38 -0500
Date: Fri, 5 Jan 2007 16:13:15 +0100 (CET)
From: Jiri Kosina <jikos@jikos.cz>
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
       Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
       linux-acpi@intel.com, linux-kernel@vger.kernel.org
Subject: Re: ACPI bay - 2.6.20-rc3-mm1 hangs on boot
In-Reply-To: <20070105143356.GA29782@khazad-dum.debian.net>
Message-ID: <Pine.LNX.4.64.0701051610540.16747@twin.jikos.cz>
References: <Pine.LNX.4.64.0701051351200.16747@twin.jikos.cz>
 <20070105143356.GA29782@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2007, Henrique de Moraes Holschuh wrote:

> > 2.6.20-rc3-mm1 hangs on boot on my IBM T42p when compiled with ACPI_BAY=y. 
> I trust you have ACPI_IBM_BAY=n to use ACPI_BAY=y ?  I don't think it has
> anything to do with the issue you have, but just in case...

The kernel hangs with CONFIG_ACPI_BAY, with CONFIG_ACPI_IBM_BAY it works 
just fine.

-- 
Jiri Kosina
