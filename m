Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966629AbWKTUVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966629AbWKTUVH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 15:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966637AbWKTUVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 15:21:07 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:14273 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S966629AbWKTUVE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 15:21:04 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: maynardj@us.ibm.com
Subject: Re: [PATCH 1/1]OProfile for Cell bug fix
Date: Mon, 20 Nov 2006 21:21:01 +0100
User-Agent: KMail/1.9.5
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <4561DCE8.20502@us.ibm.com>
In-Reply-To: <4561DCE8.20502@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200611202121.01573.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 November 2006 17:50, Maynard Johnson wrote:
>   Subject: Bug fixes for OProfile for Cell
>
> From: Maynard Johnson <maynardj@us.ibm.com>
>
> This patch contains three crucial fixes:
>         - op_model_cell.c:cell_virtual_cntr: correctly access the per-cpu
>           pmc_values arrays
>
>         - op_model_cell.c:cell_reg_setup:  initialize _all_ 4 elements of
>           pmc_values with reset_value
>
>         - include/asm-powerpc/cell-pmu.h:  fix broken macro,
> PM07_CTR_INPUT_MUX
>
> Signed-off-by: Carl Love <carll@us.ibm.com>
> Signed-off-by: Maynard Johnson <mpjohn@us.ibm.com>

Ok, looks good. I've posted the combined oprofile patch now as part of
my cell patch series for 2.6.20, using the version you sent me during
the Weekend. Can you check that everything from this patch is included
there as well?

	Arnd <><
