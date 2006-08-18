Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030417AbWHROS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030417AbWHROS5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 10:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030421AbWHROS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 10:18:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:15286 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030416AbWHROSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 10:18:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=YjjcaS/j9GZYZ2ljCMnW+KoL/Mv+yHKUn7xn2MRy92/7TvyRqtQ8ldu6oTIDJJVPRUs0eAb0jzzO7X3sp4aYDNghvQkRxiY8kphEIL+z/t6A6PmzRoCO01pokyx3xauqVjjJw34GVBQPz/Ru8+wPQEF4CH8TkCCW3eN+jHL3k+8=
Date: Fri, 18 Aug 2006 18:18:47 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Cc: netdev@vger.kernel.org, Christoph Raisch <raisch@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <osstklei@de.ibm.com>, Thomas Klein <tklein@de.ibm.com>
Subject: Re: [2.6.19 PATCH 7/7] ehea: Makefile & Kconfig
Message-ID: <20060818141847.GE5201@martell.zuzino.mipt.ru>
References: <200608181337.44153.ossthema@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608181337.44153.ossthema@de.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 01:37:44PM +0200, Jan-Bernd Themann wrote:
> --- linux-2.6.18-rc4/drivers/net/Kconfig
> +++ patched_kernel/drivers/net/Kconfig
> @@ -2277,6 +2277,12 @@ config CHELSIO_T1
>            To compile this driver as a module, choose M here: the module
>            will be called cxgb.
>
> +config EHEA
> +        tristate "eHEA Ethernet support"
> +        depends on IBMEBUS
> +        ---help---
> +          This driver supports the IBM pSeries ethernet adapter
								  .

People usually add the following boilerplate:

	To compile this driver as a module, choose M here: the module
	will be called $FOO.

