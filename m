Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263477AbTC2TU1>; Sat, 29 Mar 2003 14:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263489AbTC2TU1>; Sat, 29 Mar 2003 14:20:27 -0500
Received: from mail.iwr.uni-heidelberg.de ([129.206.104.30]:58873 "EHLO
	mail.iwr.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S263477AbTC2TU0>; Sat, 29 Mar 2003 14:20:26 -0500
Date: Sat, 29 Mar 2003 20:31:28 +0100 (CET)
From: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
To: Andrew Morton <akpm@digeo.com>
cc: "J.A. Magallon" <jamagallon@able.es>, <linux-kernel@vger.kernel.org>,
       <marcelo@conectiva.com.br>, <vortex@scyld.com>
Subject: Re: [vortex] Re: Bad PCI IDs-Names table in 3c59x.c
In-Reply-To: <20030328183836.36ccd14b.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0303292029001.28059-100000@kenzo.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Mar 2003, Andrew Morton wrote:

> +	{"3c982 Hydra Dual Port A",
> +	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },

Is there any reason for dropping the HAS_NWAY flag for these cards ? From 
what I know they have the same internal architecture as 905C (Tornado) 
which means that they have NWAY capabilities on-chip.

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De

