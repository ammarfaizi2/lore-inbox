Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbWHPQHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWHPQHr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWHPQHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:07:47 -0400
Received: from cantor.suse.de ([195.135.220.2]:30606 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751016AbWHPQHj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:07:39 -0400
Date: Wed, 16 Aug 2006 18:07:36 +0200
From: Andi Kleen <ak@suse.de>
To: Len Brown <lenb@kernel.org>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for review] [125/145] i376: Make acpi_force static
Message-Id: <20060816180736.8f6a80f8.ak@suse.de>
In-Reply-To: <200608161147.15704.len.brown@intel.com>
References: <20060810 935.775038000@suse.de>
	<20060810193724.A2B5F13C16@wotan.suse.de>
	<200608161147.15704.len.brown@intel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2006 11:47:15 -0400
Len Brown <len.brown@intel.com> wrote:

> On Thursday 10 August 2006 15:37, Andi Kleen wrote:
> 
> Ack -- assuming there was a previous patch I didn't see to move the definition of acpi_force
> to boot.c from setup.c on i386...

Yes there was. The complete early parameter parsing got changed to early_param()
and the acpi parsing is now in boot.c only.

-andi
