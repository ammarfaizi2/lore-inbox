Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264810AbTGKTRh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 15:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264844AbTGKS6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:58:09 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:34520
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S264949AbTGKScY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 14:32:24 -0400
Date: Fri, 11 Jul 2003 14:47:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: PATCH: AC97 updates from 2.4
Message-ID: <20030711184706.GD16037@gtf.org>
References: <200307111809.h6BI9Zd5017272@hraefn.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307111809.h6BI9Zd5017272@hraefn.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 07:09:35PM +0100, Alan Cox wrote:
> 
> This deals with several things
> - Codecs that think they are modems but are not
> - Abstracting modem detection out of drivers
> - Abstracting digital switching out of drivers
> - Codecs that have no volume control
> - Codec plugins for specific setups
> - Codec plugins for things like touchscreen/batmon on AC97
> - More codec handlers
> 
> The plugin API is intentionally modelled on the other driver_register
> type interfaces.

Adding another relevant point:
Only weirdos like me use the old OSS drivers, so this patch does not
affect the current (rather than deprecated) audio drivers.

(further reinforcing that this patch is OK-to-apply)

Thanks Alan,

	Jeff



