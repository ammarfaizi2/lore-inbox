Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316217AbSHNX1s>; Wed, 14 Aug 2002 19:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319334AbSHNX1s>; Wed, 14 Aug 2002 19:27:48 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:43227 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S316217AbSHNX1r>; Wed, 14 Aug 2002 19:27:47 -0400
Date: Thu, 15 Aug 2002 00:31:19 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: David Lang <david.lang@digitalinsight.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 4/21] fix ARCH_HAS_PREFETCH
Message-ID: <20020815003119.A27436@kushida.apsleyroad.org>
References: <20020814204556.GA7440@alpha.home.local> <Pine.LNX.4.44.0208141551020.14879-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208141551020.14879-100000@dlang.diginsite.com>; from david.lang@digitalinsight.com on Wed, Aug 14, 2002 at 03:53:15PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> rather then debating how to convince gcc how to not optimize them away and
> messing up the timing we should be talking about how to eliminate such
> loops in the first place.

You misunderstand.  We _do_ want gcc to optimize away empty loops.

-- Jamie
