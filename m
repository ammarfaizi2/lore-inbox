Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965379AbWAGA1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965379AbWAGA1B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965376AbWAGA1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:27:00 -0500
Received: from waste.org ([64.81.244.121]:48342 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932296AbWAGA0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:26:53 -0500
Date: Fri, 6 Jan 2006 18:20:06 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andi Kleen <ak@suse.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
Subject: Re: [patch 2/7]  enable unit-at-a-time optimisations for gcc4
Message-ID: <20060107002006.GA23554@waste.org>
References: <1136543825.2940.8.camel@laptopd505.fenrus.org> <1136543914.2940.11.camel@laptopd505.fenrus.org> <43BEA672.4010309@pobox.com> <20060106184841.GA13917@mars.ravnborg.org> <p73k6dcykar.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73k6dcykar.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 01:05:16AM +0100, Andi Kleen wrote:
> And gcc is really picky about type compatibility between source files
> with program-at-a-time.  If any types of the same symbols are
> incompatible even in minor ways you get an ICE. That's technically
> illegal, but tends to happen often in practice (e.g. when people
> use extern) It might end up being quite a lot of work to clean this up.

If it gave a useful error message rather than an ICE, that'd be a
feature.

-- 
Mathematics is the supreme nostalgia of our time.
