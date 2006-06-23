Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751947AbWFWTf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbWFWTf1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 15:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751959AbWFWTf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 15:35:27 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:28050 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751947AbWFWTf0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 15:35:26 -0400
Date: Fri, 23 Jun 2006 20:35:24 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: zippel@linux-m68k.org
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH 08/21] gcc 4 fix
Message-ID: <20060623193524.GA27946@ftp.linux.org.uk>
References: <20060623183056.479024000@linux-m68k.org> <20060623183911.847605000@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623183911.847605000@linux-m68k.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 08:31:04PM +0200, zippel@linux-m68k.org wrote:
> Fixes a "static qualifier follows non-static qualifier" error from gcc 4.
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

Broken.  Proper fix is to rename the function so that it wouldn't clash.
