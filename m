Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271405AbTHMGUz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 02:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271407AbTHMGUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 02:20:55 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:41732 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271405AbTHMGUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 02:20:54 -0400
Date: Wed, 13 Aug 2003 07:20:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Nufarul Alb <nufarul.alb@home.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: multibooting the linux kernel
Message-ID: <20030813072053.A25803@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nufarul Alb <nufarul.alb@home.ro>, linux-kernel@vger.kernel.org
References: <3F396C04.90608@home.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F396C04.90608@home.ro>; from nufarul.alb@home.ro on Wed, Aug 13, 2003 at 01:36:52AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 01:36:52AM +0300, Nufarul Alb wrote:
> There is a patch for the kernel that make it able to preload modules 
> before the acutal booting.
> 
> I wonder if this feature will be included in the official linux kernel.

Mutliboot support would be nice, not sure about the module loading thing.

But there's a bunch of issues with the paches:

(1) please port to 2.6 first because
      (a) there's not chance this will get into 2.4
      (b) 2.6 has the inkernel module loader so you don't have to duplicate
          so much loader code.
(2) please convert from GNU to Linux style
(3) please use the predefined __ASSEMBLY__ instead of ASM

