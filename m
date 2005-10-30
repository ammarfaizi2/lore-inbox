Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbVJ3WJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbVJ3WJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 17:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbVJ3WJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 17:09:57 -0500
Received: from [81.2.110.250] ([81.2.110.250]:21715 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751217AbVJ3WJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 17:09:56 -0500
Subject: Re: [PATCH 1/6] AMD Geode GX/LX Support (Refreshed)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com
In-Reply-To: <20051028154430.GB19854@cosmic.amd.com>
References: <LYRIS-4270-74122-2005.10.28-09.38.17--jordan.crouse#amd.com@whitestar.amd.com>
	 <20051028154430.GB19854@cosmic.amd.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 30 Oct 2005 22:39:30 +0000
Message-Id: <1130711970.32734.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

6_INTEL_USERCOPY
>  
>  config X86_USE_PPRO_CHECKSUM
>  	bool
> -	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2 || MEFFICEON
> +	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2 || MEFFICEON || MGEODE_LX
>  	default y


Does this mean you've now done actual performance analysis on whether
this is a good idea for Geode GX/LX ?

>  config X86_USE_3DNOW

