Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263412AbTKQJZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 04:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263415AbTKQJZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 04:25:28 -0500
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:21005 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263412AbTKQJZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 04:25:27 -0500
Date: Mon, 17 Nov 2003 09:25:17 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] disallow modular BINFMT_ELF
Message-ID: <20031117092517.A2035@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jgarzik@pobox.com>, Adrian Bunk <bunk@fs.tum.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20031115232600.GF7919@fs.tum.de> <3FB6BB35.8090001@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FB6BB35.8090001@pobox.com>; from jgarzik@pobox.com on Sat, Nov 15, 2003 at 06:48:05PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 15, 2003 at 06:48:05PM -0500, Jeff Garzik wrote:
> Adrian Bunk wrote:
> > modular BINFMT_ELF gives unresolved symbols in 2.4 .
> > 
> > modular BINFMT_ELF gives the following unresolved symbols in 2.6:
> 
> 
> Interesting.   this causes me to wonder if we should bother making 
> BINFMT_ELF an option at all...

Many nommu targets don't support ELF binaries at all.

