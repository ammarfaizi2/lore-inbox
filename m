Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbUAYXny (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 18:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbUAYXny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 18:43:54 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5017 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263130AbUAYXnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 18:43:53 -0500
Date: Mon, 26 Jan 2004 00:43:48 +0100
From: Jens Axboe <axboe@suse.de>
To: Coywolf Qi Hunt <coywolf@lovecn.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.0.39] put_last_free() defined, but not used
Message-ID: <20040125234348.GV2734@suse.de>
References: <401417A3.7000206@lovecn.org> <20040125222914.GB20879@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040125222914.GB20879@khan.acc.umu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 25 2004, David Weinehall wrote:
> On Mon, Jan 26, 2004 at 03:23:15AM +0800, Coywolf Qi Hunt wrote:
> > Hello,
> > 
> > In 2.0.39, the function put_last_free() in fs/file_table.c is defined, 
> > but no longer get used.
> > Should it be removed?
> 
> I might consider this for 2.0.41, not for 2.0.40.  Indeed it doesn't
> seem to be used, but it might be used in some external file system.

The function was static.

-- 
Jens Axboe

