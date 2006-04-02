Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751632AbWDBDyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbWDBDyl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 22:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbWDBDyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 22:54:41 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:6382 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751626AbWDBDyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 22:54:40 -0500
Date: Sat, 1 Apr 2006 19:53:49 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: open-iscsi@googlegroups.com
Cc: Core-iSCSI <Core-iSCSI@googlegroups.com>,
       iet-dev <iscsitarget-devel@lists.sourceforge.net>,
       maemo-dev <maemo-developers@maemo.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Core-iSCSI/Nokia770 binaries released!
Message-ID: <20060402035349.GA14170@us.ibm.com>
References: <1143948142.26951.199.camel@haakon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143948142.26951.199.camel@haakon>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

On Sat, Apr 01, 2006 at 07:22:22PM -0800, Nicholas A. Bellinger wrote:

> not supported in this release and 2) the 2.6.12.3-omap1 for the 770 does
> NOT ship with CONFIG_SCSI_MULTI_LUN=y, and hence we are only able to
> detect LUN 0 for each iSCSI Target Node.  Unfortuately scsi_mod is
> complied directly the 2.6.12.3-omap1 kernel and the only method to get
> around this is recompiling the kernel.  I would like to see scsi_mod
> built as a module in future kernel releases for the Nokia 770, and
> preferably with CONFIG_SCSI_MULTI_LUN=y enabled.

You should be able to override that via 

	scsi_mod.max_luns=512

Or does it have a fixed boot command line?

-- Patrick Mansfield
