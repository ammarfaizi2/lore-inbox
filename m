Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315238AbSEYTHw>; Sat, 25 May 2002 15:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315245AbSEYTHv>; Sat, 25 May 2002 15:07:51 -0400
Received: from ns.suse.de ([213.95.15.193]:56591 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315238AbSEYTHu>;
	Sat, 25 May 2002 15:07:50 -0400
Date: Sat, 25 May 2002 21:07:47 +0200
From: Dave Jones <davej@suse.de>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [patch] remove space in /proc/slabinfo cache_name
Message-ID: <20020525210747.C16102@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>, rwhron@earthlink.net,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
In-Reply-To: <20020525143356.B323@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2002 at 02:33:56PM -0400, rwhron@earthlink.net wrote:
 > Most /proc/slabinfo cache_names are in the format:
 > cache_name.  There are a couple with spaces in the
 > name, which is inconsistent and requires a special case
 > when scripting.
 > 
 > Changes "fasync cache" and "file lock cache" to have
 > the usual underscore.

Ryan Mack did this back circa 2.5.9, and also changed one extra
that you missed..

http://www.codemonkey.org.uk/patches/merged/2.5.9/dj1/slabcache-namespace.diff

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
