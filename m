Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268146AbUIWQ6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268146AbUIWQ6l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 12:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268155AbUIWQ5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 12:57:25 -0400
Received: from are.twiddle.net ([64.81.246.98]:12931 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S268182AbUIWQyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 12:54:13 -0400
Date: Thu, 23 Sep 2004 09:54:06 -0700
From: Richard Henderson <rth@twiddle.net>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: __attribute__((always_inline)) fiasco
Message-ID: <20040923165406.GB11968@twiddle.net>
Mail-Followup-To: Albert Cahalan <albert@users.sourceforge.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1095956778.4966.940.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095956778.4966.940.camel@cube>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 12:26:18PM -0400, Albert Cahalan wrote:
> Are benchmarks significantly affected if you remove the inline?

The routines in question expand to exactly one instruction.


r~
