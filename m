Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264641AbTDZJYh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 05:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264642AbTDZJYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 05:24:37 -0400
Received: from dsl-213-023-064-149.arcor-ip.net ([213.23.64.149]:56196 "EHLO
	neon.pearbough.net") by vger.kernel.org with ESMTP id S264641AbTDZJYh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 05:24:37 -0400
Date: Sat, 26 Apr 2003 11:36:48 +0200
From: Axel Siebenwirth <axel@pearbough.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4.21-rc1-ac2] undefined reference to `sync_dquots_dev'
Message-ID: <20030426093648.GB19591@neon.pearbough.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030426092938.GA19569@neon.pearbough.net> <20030426093319.GA19591@neon.pearbough.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030426093319.GA19591@neon.pearbough.net>
User-Agent: Mutt/1.4.1i
Organization: pearbough.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi linux-kernel!

On Sat, 26 Apr 2003, Axel Siebenwirth wrote:

> On Sat, 26 Apr 2003, Axel Siebenwirth wrote:
> 
> > fs/fs.o(.text+0x1baf9): In function `do_quotactl':
> > : undefined reference to `sync_dquots_dev'
> > 
> > Setting CONFIG_QUOTA helps out, but I don't want no quota support ;)
> 
> Forgive me!!! It was still rc1-ac1. Thats the result of testing patch with
> --dry-run and then don't really apllying...

I am going crazy. Yes it is rc1-ac2. Alan forgot to change EXTRAVERSION
again.
The build problem without CONFIG_QUOTA being set, still persists.

Axel Siebenwirth
