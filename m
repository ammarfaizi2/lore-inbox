Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264879AbUBNFeX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 00:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbUBNFeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 00:34:23 -0500
Received: from mxsf27.cluster1.charter.net ([209.225.28.227]:21515 "EHLO
	mxsf27.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S264879AbUBNFeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 00:34:22 -0500
Date: Fri, 13 Feb 2004 23:27:51 -0600
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.3-rc2-mm1
Message-ID: <20040214052751.GA11750@gforce.johnson.home>
References: <20040212015710.3b0dee67.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040212015710.3b0dee67.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
From: glennpj@charter.net (Glenn Johnson)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 12, 2004 at 01:57:10AM -0800, Andrew Morton wrote:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3-rc2/2.6.3-rc2-mm1/

> +sysfs-class-10-vc.patch
> 
>  Bring back this patch, see if it triggers the tty race again.

It does on one of my machines, a P4c with HT enabled.  This is the same
machine that had the problem before.  Backing out the patch "fixes" it.

-- 
Glenn Johnson
glennpj@charter.net
