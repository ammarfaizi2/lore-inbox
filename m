Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267718AbTGLBFk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 21:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267724AbTGLBFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 21:05:40 -0400
Received: from holomorphy.com ([66.224.33.161]:3773 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S267718AbTGLBFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 21:05:37 -0400
Date: Fri, 11 Jul 2003 18:21:30 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Thomas Schlichter <schlicht@uni-mannheim.de>, smiler@lanil.mine.nu,
       KML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: 2.5.74-mm2 + nvidia (and others)
Message-ID: <20030712012130.GB15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Martin Schlemmer <azarah@gentoo.org>, Andrew Morton <akpm@osdl.org>,
	Thomas Schlichter <schlicht@uni-mannheim.de>, smiler@lanil.mine.nu,
	KML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
References: <1057590519.12447.6.camel@sm-wks1.lan.irkk.nu> <200307071734.01575.schlicht@uni-mannheim.de> <20030707123012.47238055.akpm@osdl.org> <1057647818.5489.385.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057647818.5489.385.camel@workshop.saharacpt.lan>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 09:03:39AM +0200, Martin Schlemmer wrote:
> +#if defined(NV_PMD_OFFSET_UNMAP)
> +    pmd_unmap(pg_mid_dir);
> +#endif

You could try defining an NV_PMD_OFFSET_UNMAP() which is a nop for
mainline and DTRT for -mm.


-- wli
