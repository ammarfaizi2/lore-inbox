Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262519AbVGLW3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262519AbVGLW3N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 18:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbVGLWYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 18:24:42 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:34504 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262459AbVGLWWJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 18:22:09 -0400
Date: Tue, 12 Jul 2005 17:22:03 -0500
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH 2.6.13-rc1 08/10] IOCHK interface for I/O error handling/detecting
Message-ID: <20050712222203.GG26607@austin.ibm.com>
References: <42CB63B2.6000505@jp.fujitsu.com> <42CB69BD.1090607@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42CB69BD.1090607@jp.fujitsu.com>
User-Agent: Mutt/1.5.9i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 02:18:53PM +0900, Hidetoshi Seto was heard to remark:
> +static int pci_error_recovery(peidx_table_t *peidx)

Minor comment:
Maybe a different name for this routine would be good;
this potentially conflicts with generic pci routines.

--linas

