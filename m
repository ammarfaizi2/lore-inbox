Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262546AbVCPLMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbVCPLMv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 06:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262548AbVCPLMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 06:12:51 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:64775
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S262546AbVCPLMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 06:12:48 -0500
Date: Wed, 16 Mar 2005 12:12:47 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Noah Meyerhans <noahm@csail.mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOM problems with 2.6.11-rc4
Message-ID: <20050316111247.GD11192@opteron.random>
References: <20050315204413.GF20253@csail.mit.edu> <20050316003134.GY7699@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316003134.GY7699@opteron.random>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2005 at 01:31:34AM +0100, Andrea Arcangeli wrote:
> In short I think we can start by trying this fix (which has some risk,
> since now it might become harder to detect an oom condition, but I don't

Some testing shows that oom conditions are still detected fine (I
expected this but I wasn't completely sure until I tested it ;). Now the
main question is if this is enough to fix your problem or if there are
more hidden bugs in the same area.
