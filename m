Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131638AbRDSRt3>; Thu, 19 Apr 2001 13:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131631AbRDSRtP>; Thu, 19 Apr 2001 13:49:15 -0400
Received: from t2.redhat.com ([199.183.24.243]:64760 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S131630AbRDSRsu>; Thu, 19 Apr 2001 13:48:50 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010419131944.A3049@thyrsus.com> 
In-Reply-To: <20010419131944.A3049@thyrsus.com> 
To: esr@thyrsus.com
Cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: Dead symbol elimination, stage 1 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 19 Apr 2001 18:48:25 +0100
Message-ID: <16626.987702505@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -# CONFIG_MTD_SBC_MEDIAGX is not set
> -# CONFIG_MTD_ELAN_104NC is not set
> -# CONFIG_MTD_SA1100 is not set
> -# CONFIG_MTD_DC21285 is not set
> -# CONFIG_MTD_CSTM_CFI_JEDEC is not set
>  # CONFIG_MTD_JEDEC is not set
>  # CONFIG_MTD_MIXMEM is not set
>  # CONFIG_MTD_OCTAGON is not set
>  # CONFIG_MTD_VMAX is not set
> -# CONFIG_MTD_NAND is not set
> -# CONFIG_MTD_NAND_SPIA is not set

Please don't. People using some of these embedded architectures need to
update to the latest MTD code (which includes those options) anyway, and I'm
hoping to merge that all into 2.4 shortly.

They're not doing any harm, are they?

--
dwmw2


