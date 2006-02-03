Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946107AbWBCXzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946107AbWBCXzE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 18:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946105AbWBCXzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 18:55:04 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:16571 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1030249AbWBCXzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 18:55:02 -0500
Subject: Re: [PATCH 2/2] megaraid_sas: support for 1078 type controller
	added
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Moore, Eric" <Eric.Moore@lsil.com>, Sumant Patro <sumantp@lsil.com>
Cc: hch@lst.de, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       sreenib@lsil.com, Neela.kolli@lsil.com, Bo.Yang@lsil.com,
       hdoelfel@lsil.com
In-Reply-To: <1139009675.602.15.camel@dhcp80-31.lsil.com>
References: <1139009675.602.15.camel@dhcp80-31.lsil.com>
Content-Type: text/plain
Date: Fri, 03 Feb 2006 17:54:49 -0600
Message-Id: <1139010889.9267.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-03 at 15:34 -0800, Sumant Patro wrote:
>         {
> +        PCI_VENDOR_ID_LSI_LOGIC,
> +        PCI_DEVICE_ID_LSI_SAS1078R, // ppc IOP
> +        PCI_ANY_ID,
> +        PCI_ANY_ID,
> +       },

I thought the fusion people objected to this because they also have a
fusion card with this id; has that now been resolved?

James


