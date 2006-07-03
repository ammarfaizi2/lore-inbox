Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWGCBq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWGCBq3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 21:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbWGCBq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 21:46:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:60511 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750885AbWGCBq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 21:46:28 -0400
X-IronPort-AV: i="4.06,199,1149490800"; 
   d="scan'208"; a="59750749:sNHT21547540"
From: Yu Luming <luming.yu@intel.com>
Organization: Intel
To: Johan Vromans <jvromans@squirrel.nl>
Subject: Re: RFC [PATCH] acpi: allow SMBus access
Date: Mon, 3 Jul 2006 09:51:29 +0800
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <17576.14005.767262.868190@phoenix.squirrel.nl>
In-Reply-To: <17576.14005.767262.868190@phoenix.squirrel.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607030951.29345.luming.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 July 2006 05:12, Johan Vromans wrote:
> From: Johan Vromans <jvromans@squirrel.nl>
>
> To get battery readings on some laptops it is necessary to interface
> with the SMBus that hangs of the EC. However, the current
> implementation of the EC driver does not permit other modules
> read/write access.

why NOT use ec_read/ec_write?

-- 
Thanks,
Luming
