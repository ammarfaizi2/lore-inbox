Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268229AbUHXTiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268229AbUHXTiI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 15:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268240AbUHXTiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 15:38:08 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:16905 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268229AbUHXTiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 15:38:06 -0400
Date: Tue, 24 Aug 2004 20:38:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: ppc64 cross compiler hangs in infinite loop while compiling kernel/posix-timers.c optimised
Message-ID: <20040824203804.A32368@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chris Friesen <cfriesen@nortelnetworks.com>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <412B9758.5050804@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <412B9758.5050804@nortelnetworks.com>; from cfriesen@nortelnetworks.com on Tue, Aug 24, 2004 at 03:30:32PM -0400
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 03:30:32PM -0400, Chris Friesen wrote:
> I'm using a crosstool-generated ppc64 cross compiler for ppc.  Specifically, its 
> the 3.4.0 compiler.

Upgrade to gcc 3.4.1, this is a bug in 3.4.1 (and unfortunately not mentioned
in the relnotes for 3.4.1)

