Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293035AbSCVHwV>; Fri, 22 Mar 2002 02:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293095AbSCVHwM>; Fri, 22 Mar 2002 02:52:12 -0500
Received: from ns.suse.de ([213.95.15.193]:35343 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S293035AbSCVHwC>;
	Fri, 22 Mar 2002 02:52:02 -0500
Date: Fri, 22 Mar 2002 08:52:01 +0100
From: Dave Jones <davej@suse.de>
To: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.7 make modules_install failed
Message-ID: <20020322085201.O22861@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C9A3043.4AA87A26@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2002 at 08:10:59PM +0100, Jean-Luc Coulon wrote:
 > depmod: 	virt_to_bus_not_defined_use_pci_map

As the warning suggests, you tried to build a module that isn't
updated to use the new pci mapping api. Either fix it, or if you
don't know how, take the wussy way out, and use -dj and undefine
CONFIG_DEBUG_OBSOLETE  8-)
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
