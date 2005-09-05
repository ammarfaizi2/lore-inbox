Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbVIEB4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbVIEB4X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 21:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbVIEB4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 21:56:23 -0400
Received: from twinlark.arctic.org ([207.7.145.18]:59834 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S932167AbVIEB4X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 21:56:23 -0400
Date: Sun, 4 Sep 2005 18:56:22 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Alex Davis <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: i386: kill !4KSTACKS
In-Reply-To: <20050905014153.GD3741@stusta.de>
Message-ID: <Pine.LNX.4.63.0509041845270.1559@twinlark.arctic.org>
References: <20050905013030.14361.qmail@web50211.mail.yahoo.com>
 <20050905014153.GD3741@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Sep 2005, Adrian Bunk wrote:

> How do you put pressure on hardware manufacturers for getting them to 
> release the specs?
> 
> If they are able to write "supported by Linux" on their products anyway 
> because there's a driver that runs under NdisWrapper?

that's specious... they can put "supported by Linux" on their products by 
supplying a binary-only driver too... ndiswrapper is orthogonal to that 
problem.

on a tangent... has there been any further research/work on page 
clustering?  wli's patches haven't been updated in a while... it's another 
way to supply larger stacks.  (hell with 16KiB "pages" i'd be stoked to 
"waste" the bottom 4KiB of each stack with an unmapped page to ensure 
overflow is detected.)

-dean
