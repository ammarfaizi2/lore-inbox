Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264582AbTEPTLU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 15:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264593AbTEPTLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 15:11:19 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:39840 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264582AbTEPTLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 15:11:19 -0400
Date: Fri, 16 May 2003 20:25:55 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Andreas Henriksson <andreas@fjortis.info>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.69-mm6
Message-ID: <20030516192555.GB19669@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andreas Henriksson <andreas@fjortis.info>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030516015407.2768b570.akpm@digeo.com> <20030516172834.GA9774@foo> <20030516175539.GA16626@suse.de> <20030516181042.GA556@foo> <20030516183033.GA18042@suse.de> <20030516190233.GA624@foo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030516190233.GA624@foo>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 16, 2003 at 09:02:33PM +0200, Andreas Henriksson wrote:

 > Ok... I'll add some more info here just in case.... 
 > When it switches to framebuffer a white square appears in the upper left
 > corner.. (a 640x480 window?).... it dissapears when text (and the
 > penguin) is drawn over it...

Sounds like you're using FB. Weird. I heard from another user 810fb was broken.
Maybe something got fixed that made it 'just work'.

 > (same for all the 2.5:s I've tried) ... 
 > in 2.5.69-mm6 the penguin was missing... (maybee I did a mistake in the
 > config... all four CONFIG_LOGO_.. stuff enabled).

known bug. Fix posted to l-k a few times.

		Dave
