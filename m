Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVAaUXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVAaUXi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 15:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVAaUXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 15:23:37 -0500
Received: from lists.us.dell.com ([143.166.224.162]:52652 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S261340AbVAaUXg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 15:23:36 -0500
Date: Mon, 31 Jan 2005 14:23:26 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: dm-devel@redhat.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [dm-devel] [PATCH 2.6.11-rc2] dm-ioctl.c: use new kstrdup() from library
Message-ID: <20050131202326.GC24164@lists.us.dell.com>
References: <20050131192859.GB24164@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050131192859.GB24164@lists.us.dell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 01:28:59PM -0600, Matt Domsch wrote:
> Removes private kstrdup() function, uses new implementation in lib/string.c.
> 
> Required to build.

Note, this assumes that Rusty's lib/string.c:kstrdup() patch gets
applied first.

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
