Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262255AbUKKPV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbUKKPV0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 10:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbUKKPSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 10:18:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:493 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262255AbUKKPRb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 10:17:31 -0500
Date: Thu, 11 Nov 2004 15:17:27 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Adrian Bunk <bunk@stusta.de>
Cc: Len Brown <len.brown@intel.com>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [ACPI] [2.6 patch] drivers/acpi: #ifdef unused functions away
Message-ID: <20041111151727.GB1108@parcelfarce.linux.theplanet.co.uk>
References: <20041105215021.GF1295@stusta.de> <1099707007.13834.1969.camel@d845pe> <20041106114844.GK1295@stusta.de> <418CEE3A.40503@conectiva.com.br> <20041106212917.GP1295@stusta.de> <418D403E.30608@conectiva.com.br> <1099933263.13831.9547.camel@d845pe> <20041110012134.GB4089@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041110012134.GB4089@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 02:21:34AM +0100, Adrian Bunk wrote:
> This patch only #ifdef's completely unused code away - it does not make 
> the many global functions only used inside the file they are defined in 
> static.

It also ifdefs out the acpi_install_gpe_handler and acpi_remove_gpe_handler
calls I use in the driver I posted on Sunday.  Please fix this.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
