Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267008AbSL3RGq>; Mon, 30 Dec 2002 12:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267010AbSL3RGq>; Mon, 30 Dec 2002 12:06:46 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:4293 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267008AbSL3RGp>;
	Mon, 30 Dec 2002 12:06:45 -0500
Date: Mon, 30 Dec 2002 17:12:48 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       kernel-janitor-discuss@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Current unclaimed 2.5 bugs on bugme.osdl.org
Message-ID: <20021230171248.GB20224@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	kernel-janitor-discuss@lists.sourceforge.net,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <129460000.1041214462@titus> <1041255152.544.14.camel@zion.wanadoo.fr> <299610000.1041267777@titus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <299610000.1041267777@titus>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2002 at 09:02:58AM -0800, Martin J. Bligh wrote:

 > >>117 nor mbligh@aracnet.com OPEN build failure: arch/ppc/kernel/process.c
 > >
 > >Works in current ppc bk tree, probably waiting for next round of merges
 > >by Paul Mackerras to Linus.
 > 
 > According to DaveJ, this should be fixed in 51 ... anyone able to test?

user_tid isn't referenced there any longer, so the bug should be closed afaics.
If it still doesn't compile, it's likely unrelated to this bug.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
