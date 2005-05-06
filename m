Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbVEFAkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbVEFAkx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 20:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVEFAkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 20:40:53 -0400
Received: from s-utl01-nypop.stsn.com ([199.106.90.52]:3520 "HELO
	s-utl01-nypop.stsn.com") by vger.kernel.org with SMTP
	id S262009AbVEFAku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 20:40:50 -0400
Subject: Re: make smp_prepare_cpu to a weak function
From: Arjan van de Ven <arjan@infradead.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, zwane@arm.linux.org.uk,
       shaohua.li@intel.com
In-Reply-To: <20050505170727.A17919@unix-os.sc.intel.com>
References: <20050505170727.A17919@unix-os.sc.intel.com>
Content-Type: text/plain
Date: Thu, 05 May 2005 20:40:27 -0400
Message-Id: <1115340027.6503.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-05 at 17:07 -0700, Ashok Raj wrote:
> +int __attribute__((weak)) smp_prepare_cpu (int cpu)
> +{
> +	return 0;
> +}


ehhh what does this attribute mean here?????


