Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbUDAARK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 19:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbUDAARK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 19:17:10 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:51152 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262153AbUDAARG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 19:17:06 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-mm2
Date: Wed, 31 Mar 2004 16:16:58 -0800
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>
References: <20040317201454.5b2e8a3c.akpm@osdl.org> <20040331155626.3f196a18.akpm@osdl.org> <200403311558.28178.jbarnes@sgi.com>
In-Reply-To: <200403311558.28178.jbarnes@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403311616.58299.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 March 2004 3:58 pm, Jesse Barnes wrote:
> > Could you also punt me over the .config?  If I can make it happen, the
> > binary search will find it.  But it probably won't happen here.
>
> I'm using sn2_defconfig in arch/ia64/configs.

It's the 32k slab and it something that I enabled between -rc1-mm1 and 
-rc1-mm2 in sn2_defconfig.  Arg!  I didn't think to check the config file 
first since it works fine in other trees.  Oh well, I'm building with slab 
debugging enabled now (and the naughty config file)...

Jesse
