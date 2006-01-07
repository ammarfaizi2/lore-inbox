Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030615AbWAGWN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030615AbWAGWN2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 17:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030616AbWAGWN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 17:13:28 -0500
Received: from spooner.celestial.com ([192.136.111.35]:21138 "EHLO
	spooner.celestial.com") by vger.kernel.org with ESMTP
	id S1030615AbWAGWN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 17:13:27 -0500
Date: Sat, 7 Jan 2006 17:13:24 -0500
From: Kurt Wall <kwall@kurtwerks.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
Subject: Re: [patch 7/7] Make "inline" no longer mandatory for gcc 4.x
Message-ID: <20060107221324.GB11606@kurtwerks.com>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <1136543825.2940.8.camel@laptopd505.fenrus.org> <1136544309.2940.25.camel@laptopd505.fenrus.org> <20060107190531.GB8990@kurtwerks.com> <1136663088.2936.36.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136663088.2936.36.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.15krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 08:44:48PM +0100, Arjan van de Ven took 25 lines to write:
> On Sat, 2006-01-07 at 14:05 -0500, Kurt Wall wrote:
> 
> > 
> > This patch was applied on top of the previous 6 in the series from
> > Arjan. NB that it _did_ build with 3.4.4 and -Os enabled. I'm
> > rechecking, but this is the second time I've encountered this failure.
> 
> 
> Does this fix it?

Yes. It compiles and links. I'll have some numbers to post shortly that
demonstrate the cumulative effect of this patch series, which will
include this patch because it is necessary to get the kernel to link
with gcc 4.0.2.

Kurt
-- 
"Honesty is the best policy, but insanity is a better defense"
