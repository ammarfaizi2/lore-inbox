Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315293AbSFIXWH>; Sun, 9 Jun 2002 19:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315334AbSFIXWG>; Sun, 9 Jun 2002 19:22:06 -0400
Received: from ns.suse.de ([213.95.15.193]:28169 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315293AbSFIXWG>;
	Sun, 9 Jun 2002 19:22:06 -0400
Date: Mon, 10 Jun 2002 01:22:07 +0200
From: Dave Jones <davej@suse.de>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.21] i386 arch subdivision into machine types
Message-ID: <20020610012207.L13140@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200206091729.g59HTnv08471@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2002 at 01:29:49PM -0400, James Bottomley wrote:
 > This code rearranges the arch/i386 directory structure to allow for sliding 
 > additional non-pc hardware in here in an easily separable (and thus easily 
 > maintainable) fashion.  The idea is that all the code for the particular 
 > problem hardware should be able to go in a separate directory with only 
 > additional build options in config.in.

Now that Linus has taken Patricks large reorganisation, I think we're
ready to start looking at this.   I'll experiment with it a little when
I get around to syncing against 2.5.21

        Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
