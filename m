Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbUKFUji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbUKFUji (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 15:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUKFUjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 15:39:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22457 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261467AbUKFUjg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 15:39:36 -0500
Date: Sat, 6 Nov 2004 20:39:34 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Adrian Bunk <bunk@stusta.de>
Cc: len.brown@intel.com, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ACPI] [2.6 patch] drivers/acpi: remove unused exported functions
Message-ID: <20041106203934.GA27251@parcelfarce.linux.theplanet.co.uk>
References: <20041105215021.GF1295@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105215021.GF1295@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 10:50:21PM +0100, Adrian Bunk wrote:
> -acpi_status
> -acpi_install_gpe_block (
> -	acpi_handle                     gpe_device,
> -	struct acpi_generic_address     *gpe_block_address,
> -	u32                             register_count,
> -	u32                             interrupt_level);
> -
> -acpi_status
> -acpi_remove_gpe_block (
> -	acpi_handle                     gpe_device);
> -

I just wrote a driver that uses these two.  Probably best if you refer to
http://developer.intel.com/technology/iapc/acpi/downloads/ACPICA-ProgRef.pdf
before deleting "unused" functions as these are part of the published
interfaces that the ACPICA provides.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
