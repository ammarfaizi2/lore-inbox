Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290310AbSAPA46>; Tue, 15 Jan 2002 19:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289804AbSAPA4s>; Tue, 15 Jan 2002 19:56:48 -0500
Received: from ns.suse.de ([213.95.15.193]:18962 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290313AbSAPAzO>;
	Tue, 15 Jan 2002 19:55:14 -0500
Date: Wed, 16 Jan 2002 01:55:13 +0100
From: Dave Jones <davej@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: David Weinehall <tao@acc.umu.se>, Benjamin LaHaise <bcrl@redhat.com>,
        John Weber <weber@nyc.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.5.3-pre1 compile error
Message-ID: <20020116015513.L32088@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	David Weinehall <tao@acc.umu.se>, Benjamin LaHaise <bcrl@redhat.com>,
	John Weber <weber@nyc.rr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020116013811.E5235@khan.acc.umu.se> <Pine.LNX.4.33.0201151639320.1213-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201151639320.1213-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Jan 15, 2002 at 04:41:08PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 04:41:08PM -0800, Linus Torvalds wrote:
 > > #ifndef _LINUX_POSIX_TYPES_H   /* __FD_CLR */
 > > #include <linux/posix_types.h>
 > > #endif
 > If this actally makes any noticeable difference to compilation speed I
 > could live with it. Does it?

 I'm sure I read somewhere that gcc is clever enough to know
 when it hits a #include, it checks for a symbol equal to a
 mangled version of the filename before including it.
 (Ie, doing this transparently).

 Then again, I may have imagined it all.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
