Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266479AbUGKCXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266479AbUGKCXx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 22:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266482AbUGKCXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 22:23:53 -0400
Received: from fmr99.intel.com ([192.55.52.32]:48588 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S266479AbUGKCXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 22:23:51 -0400
Subject: Re: 2.6.7-mm7
From: Len Brown <len.brown@intel.com>
To: Zoltan Boszormenyi <zboszor@dunaweb.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FFB70@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FFB70@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1089512622.32038.17.camel@dhcppc2>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 10 Jul 2004 22:23:42 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-10 at 02:21, Zoltan Boszormenyi wrote:
> Hi,
> 
> I found in my logs something that indicates problems with ACPI:
> 
> ACPI: Subsystem revision 20040615
> ACPI: System description tables not found
>      ACPI-0084: *** Error: acpi_load_tables: Could not get RSDP, 
> AE_NOT_FOUND
>      ACPI-0134: *** Error: acpi_load_tables: Could not load tables: 
> AE_NOT_FOUND
> ACPI: Unable to load the System Description Tables
...
> Machine is MSI K8T Neo FIS2R with fairly recent 1.6 BIOS.
> I dont have this with Linux-2.6.7.

Interesting, we'd seen this BIOS bug only on Dell so far.

Please test the patch here:
http://bugzilla.kernel.org/show_bug.cgi?id=2990

thanks,
-Len


