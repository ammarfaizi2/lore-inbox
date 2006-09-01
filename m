Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWIAAIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWIAAIP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 20:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWIAAIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 20:08:15 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:5522 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964825AbWIAAIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 20:08:14 -0400
Date: Fri, 1 Sep 2006 10:07:45 +1000
From: Nathan Scott <nathans@sgi.com>
To: Richard Knutsson <ricknu-0@student.ltu.se>
Cc: akpm@osdl.org, xfs-masters@oss.sgi.com, xfs@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc4-mm3 2/2] fs/xfs: Correcting error-prone boolean-statement
Message-ID: <20060901100745.P3186664@wobbly.melbourne.sgi.com>
References: <44F77653.6000606@student.ltu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <44F77653.6000606@student.ltu.se>; from ricknu-0@student.ltu.se on Fri, Sep 01, 2006 at 01:52:51AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2006 at 01:52:51AM +0200, Richard Knutsson wrote:
> From: Richard Knutsson <ricknu-0@student.ltu.se>
> 
> Converting error-prone statement:
> "if (var == B_FALSE)" into "if (!var)"
> "if (var == B_TRUE)"  into "if (var)"

This is my preference too, rather than the local boolean usage which
isn't used with any consistency... but:

> Compile-tested

Are you using XFS on your systems?  What is your strategy for getting this
runtime tested going to be?  Or are you delegating that responsibility? :)

cheers.

-- 
Nathan
