Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbWGCIWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWGCIWV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 04:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWGCIWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 04:22:21 -0400
Received: from poup.poupinou.org ([195.101.94.96]:43556 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S1750868AbWGCIWV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 04:22:21 -0400
Date: Mon, 3 Jul 2006 10:22:17 +0200
To: Johan Vromans <jvromans@squirrel.nl>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: RFC [PATCH] acpi: allow SMBus access
Message-ID: <20060703082217.GB17014@poupinou.org>
References: <17576.14005.767262.868190@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17576.14005.767262.868190@phoenix.squirrel.nl>
User-Agent: Mutt/1.5.9i
From: Bruno Ducrot <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 02, 2006 at 11:12:21PM +0200, Johan Vromans wrote:
> From: Johan Vromans <jvromans@squirrel.nl>
> 
> To get battery readings on some laptops it is necessary to interface
> with the SMBus that hangs of the EC. However, the current
> implementation of the EC driver does not permit other modules
> read/write access.
> 
> A trivial solution is to change acpi_ec_read/write from static to
> nonstatic, and export the symbols so other modules can use them.
> 
> This patch is based on the current 2.6.17 kernel sources.

I don't think this patch is correct, or else I would have already
asked this patch being added to mainline.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
