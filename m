Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270308AbTGMRLs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 13:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270311AbTGMRLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 13:11:47 -0400
Received: from are.twiddle.net ([64.81.246.98]:43197 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S270308AbTGMRLq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 13:11:46 -0400
Date: Sun, 13 Jul 2003 10:26:23 -0700
From: Richard Henderson <rth@twiddle.net>
To: Matthew Wilcox <willy@debian.org>
Cc: Bernardo Innocenti <bernie@develer.com>, Andrew Morton <akpm@zip.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: do_div vs sector_t
Message-ID: <20030713172622.GA13824@twiddle.net>
Mail-Followup-To: Matthew Wilcox <willy@debian.org>,
	Bernardo Innocenti <bernie@develer.com>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
References: <20030711223359.GP20424@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030711223359.GP20424@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 11:33:59PM +0100, Matthew Wilcox wrote:
> Better ideas?

          if (likely(((n) >> 31 >> 1) == 0)) {


r~
