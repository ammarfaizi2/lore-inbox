Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbWF1Sla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbWF1Sla (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 14:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWF1Sla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 14:41:30 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:8155 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750935AbWF1Sl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 14:41:29 -0400
Date: Wed, 28 Jun 2006 13:40:23 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: akpm@osdl.org
Cc: Adrian Bunk <bunk@stusta.de>,
       Phillip Hellewell <phillip@hellewell.homeip.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] fs/ecryptfs/: possible cleanups
Message-ID: <20060628184023.GF14557@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20060627015211.ce480da6.akpm@osdl.org> <20060628165525.GG13915@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628165525.GG13915@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 06:55:25PM +0200, Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - make needlessly global functions static
> - there's usually no reason for functions in C files to be marked as
>   inline - gcc usually knows best whether or not to inline a function
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Michael Halcrow <mhalcrow@us.ibm.com>
