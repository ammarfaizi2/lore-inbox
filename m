Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbUG1TTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUG1TTn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 15:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUG1TTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 15:19:42 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:50675 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262391AbUG1TTi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 15:19:38 -0400
Subject: Re: [announce][draft3] HVCS for inclusion in 2.6 tree
From: Ryan Arnold <rsa@us.ibm.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <20040727155011.77897e68.rddunlap@osdl.org>
References: <1089819720.3385.66.camel@localhost>
	 <16633.55727.513217.364467@cargo.ozlabs.ibm.com>
	 <1090528007.3161.7.camel@localhost> <20040722191637.52ab515a.akpm@osdl.org>
	 <1090958938.14771.35.camel@localhost>
	 <20040727155011.77897e68.rddunlap@osdl.org>
Content-Type: text/plain
Organization: IBM
Message-Id: <1091034031.14771.292.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Jul 2004 12:00:31 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-27 at 17:50, Randy.Dunlap wrote:
> +int hvcs_convert(long to_convert)
> +{
> +	switch (to_convert) {
> +		case H_Success:
> +			return 0;
> +		case H_Parameter:
> +			return -EINVAL;
> +		case H_Hardware:
> +			return -EIO;
> +		case H_Busy:
> 
> Can these H_values be converted from that coding style?

Randy, if you mean you'd like to see H_SUCCESS, H_PARAMETER, etc, I'd
like to point out that all of the documentation I worked from uses the
convention you see in my code.  Additionally, all of these hcall return
codes already exist in include/asm-pp64/hvcall.h and have for some time.

Ryan S. Arnold
IBM Linux Technology Center

