Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313026AbSDYKN0>; Thu, 25 Apr 2002 06:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313027AbSDYKNZ>; Thu, 25 Apr 2002 06:13:25 -0400
Received: from ns.suse.de ([213.95.15.193]:18440 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313026AbSDYKNZ>;
	Thu, 25 Apr 2002 06:13:25 -0400
Date: Thu, 25 Apr 2002 12:13:09 +0200
From: Dave Jones <davej@suse.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Warn about trap for programmer in mm.h
Message-ID: <20020425121308.I14343@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Pavel Machek <pavel@ucw.cz>,
	Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
	kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020425100440.GA5061@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2002 at 12:04:40PM +0200, Pavel Machek wrote:
 >  #define PG_private		16	/* Has something at ->private */
 > +/* Top 8 bits are used for page's zone in 2.4-ac and 2.5, don't use them */
 >  

Erm, and 2.4 mainline these days isn't it?

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
