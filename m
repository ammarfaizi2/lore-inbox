Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263997AbTE3Uwz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 16:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264002AbTE3Uwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 16:52:55 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:14499 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263997AbTE3Uwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 16:52:54 -0400
Date: Fri, 30 May 2003 23:06:10 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Steven Cole <elenstev@mesatop.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] 2.5 Documentation/CodingStyle ANSI C function declarations.
Message-ID: <20030530210610.GD3308@wohnheim.fh-wedel.de>
References: <1054324633.3754.119.camel@spc9.esa.lanl.gov> <20030530201429.GA3308@wohnheim.fh-wedel.de> <1054326307.3751.124.camel@spc9.esa.lanl.gov> <20030530204055.GB3308@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030530204055.GB3308@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 May 2003 22:40:55 +0200, Jörn Engel wrote:
> 
> I would agree with that strategy, if the zlib wasn't actively
> maintained anymore and we'd have to take over that part anyway.  But
> as it is, this will create extra work with little bonus on our side,
> except to set a better example maybe.

In related news, the kernel zlib still claims to be 1.1.3.  The
security bug fixed with 1.1.4 was a double-free problem which doesn't
apply to the kernel version anymore, but other functional changes were
missed as well.  Does anyone really understand what those changes are
about? David perhaps?

If not, I will prepare a patch.

Jörn

-- 
They laughed at Galileo.  They laughed at Copernicus.  They laughed at
Columbus. But remember, they also laughed at Bozo the Clown.
-- unknown
