Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932647AbVKBIWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932647AbVKBIWD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 03:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932646AbVKBIWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 03:22:01 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49593 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932644AbVKBIV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 03:21:58 -0500
Date: Wed, 2 Nov 2005 00:21:42 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: Ashutosh Naik <ashutosh.naik@gmail.com>, support@qlogic.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       stable@kernel.org
Subject: Re: [stable] Re: [PATCH] scsi - Fix Broken Qlogic ISP2x00 Device Driver
Message-ID: <20051102082142.GW5856@shell0.pdx.osdl.net>
References: <81083a450511012313v25e292duf7b64da0ebf07835@mail.gmail.com> <20051102080711.GB626@plapn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051102080711.GB626@plapn>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Vasquez (andrew.vasquez@qlogic.com) wrote:
> On Wed, 02 Nov 2005, Ashutosh Naik wrote:
> 
> > This patch fixes the fact that although the scsi_transport_fc.h header
> > file is not included in qla_def.h, we still reference the function
> > fc_remote_port_unlock in the qlogic  ISP2x00 device driver ,
> > qla2xxx/qla_rscn.c
> 
> Perhaps for the stable tree (2.6.14.x) this fix is appropriate.  The
> scsi-misc-2.6.git tree already has codes which address this issue.

It's preferable to have that fix pending in scsi-misc for -stable.

thanks,
-chris
