Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030518AbVKPVmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030518AbVKPVmA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 16:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030520AbVKPVmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 16:42:00 -0500
Received: from isilmar.linta.de ([213.239.214.66]:9710 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1030515AbVKPVl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 16:41:58 -0500
Date: Wed, 16 Nov 2005 22:41:52 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Thomas Meyer <thomas.mey@web.de>
Cc: linux-kernel@vger.kernel.org, hugh@veritas.com
Subject: Re: 2.6.15-rc1-g0db169f9 error with MAP_PRIVATE, PROT_WRITE mmap of VM_RESERVED
Message-ID: <20051116214152.GA8922@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Thomas Meyer <thomas.mey@web.de>, linux-kernel@vger.kernel.org,
	hugh@veritas.com
References: <2008856008@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2008856008@web.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 16, 2005 at 10:30:46PM +0100, Thomas Meyer wrote:
> 
> [17180027.952000] program vbetool is using MAP_PRIVATE, PROT_WRITE mmap of VM_RESERVED memory, which is deprecated. Please report this to linux-kernel@vger.kernel.org
> 
> Does anybody care?

Yes -- thanks for the report. AFAIK, Hugh Dickins tries to prepare a patch
for 2.6.15-rc2 solving this issue.

	Dominik
