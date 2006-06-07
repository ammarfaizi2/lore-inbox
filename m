Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWFGHg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWFGHg4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 03:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWFGHgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 03:36:55 -0400
Received: from cantor2.suse.de ([195.135.220.15]:24737 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751110AbWFGHgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 03:36:55 -0400
To: "bibo,mao" <bibo.mao@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_86 msi miss one entry handler
References: <44866B23.6000302@intel.com>
From: Andi Kleen <ak@suse.de>, 5B@suse.de
Date: 07 Jun 2006 09:36:53 +0200
In-Reply-To: <44866B23.6000302@intel.com>
Message-ID: <p734pyxo1re.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"bibo,mao" <bibo.mao@intel.com> writes:

> Hi,
>   In x86_64 architecture, if device driver with msi function
> gets 0xee vector by assign_irq_vector() function, system will
> crash if this interrupt happens. It is because 0xee interrupt
> entry is empty. This patch modifies this. This patch is based
> on 2.6.17-rc6.


Looks good. I will queue the patch.

-Andi
