Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbTITUv3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 16:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbTITUv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 16:51:29 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:15632 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S261966AbTITUvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 16:51:25 -0400
Date: Sat, 20 Sep 2003 22:51:23 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Nathan T. Lynch" <ntl@pobox.com>
Cc: mec@shout.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove cscope.out during make mrproper
Message-ID: <20030920205123.GB3681@mars.ravnborg.org>
Mail-Followup-To: "Nathan T. Lynch" <ntl@pobox.com>, mec@shout.net,
	linux-kernel@vger.kernel.org
References: <20030909052828.GB1802@biclops.private.network>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030909052828.GB1802@biclops.private.network>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 12:28:28AM -0500, Nathan T. Lynch wrote:
> Hi-
> 
> The attached patch fixes the toplevel Makefile to remove cscope.out
> during make mrproper.  The default name for the database that cscope
> creates is cscope.out, and this is what the cscope rule in the
> makefile uses.  Currently, mrproper will leave cscope.out behind,
> which can make for interesting diffs...

Thanks.
Added to my local tree and forwarded to Linus.

	Sam
