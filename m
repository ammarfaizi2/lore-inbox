Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbWGCIW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWGCIW6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 04:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbWGCIW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 04:22:58 -0400
Received: from poup.poupinou.org ([195.101.94.96]:44324 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S1750893AbWGCIW5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 04:22:57 -0400
Date: Mon, 3 Jul 2006 10:22:52 +0200
To: Yu Luming <luming.yu@intel.com>
Cc: Johan Vromans <jvromans@squirrel.nl>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: Re: RFC [PATCH] acpi: allow SMBus access
Message-ID: <20060703082252.GC17014@poupinou.org>
References: <17576.14005.767262.868190@phoenix.squirrel.nl> <200607030951.29345.luming.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607030951.29345.luming.yu@intel.com>
User-Agent: Mutt/1.5.9i
From: Bruno Ducrot <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 09:51:29AM +0800, Yu Luming wrote:
> On Monday 03 July 2006 05:12, Johan Vromans wrote:
> > From: Johan Vromans <jvromans@squirrel.nl>
> >
> > To get battery readings on some laptops it is necessary to interface
> > with the SMBus that hangs of the EC. However, the current
> > implementation of the EC driver does not permit other modules
> > read/write access.
> 
> why NOT use ec_read/ec_write?

Because ec_read/ec_write only handle one EC, maybe ?

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
