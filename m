Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267848AbTAMM3z>; Mon, 13 Jan 2003 07:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267872AbTAMM3z>; Mon, 13 Jan 2003 07:29:55 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:6797 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267848AbTAMM3y>;
	Mon, 13 Jan 2003 07:29:54 -0500
Date: Mon, 13 Jan 2003 12:36:35 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: some curiosities on the filesystems layout in kernel config
Message-ID: <20030113123635.GD9031@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Robert P. J. Day" <rpjday@mindspring.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0301120053420.21687-100000@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301120053420.21687-100000@dell>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 01:00:40AM -0500, Robert P. J. Day wrote:

 > 1) where is the USMDOS selection that's listed in the Kconfig file?
 >    it doesn't appear in the menu

currently broken. this needs fixing at some point for 2.6

 > 2) shouldn't ext3 depend on ext2?

nope.

 > 3) currently, since quotas are only supported for ext2, ext3 and
 >    reiserfs, shouldn't quotas depend on at least one of those
 >    being selected?

Could do, but it's the Kconfig gets messy very quickly when you
have realise that any of those fs's can also be modular.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
