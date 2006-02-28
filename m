Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbWB1VJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbWB1VJL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 16:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbWB1VJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 16:09:11 -0500
Received: from ns2.suse.de ([195.135.220.15]:61893 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932439AbWB1VJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 16:09:10 -0500
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] x86_64: fix orphaned bits of timer init messages
Date: Tue, 28 Feb 2006 22:09:03 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <200602281604_MC3-1-B984-EC14@compuserve.com>
In-Reply-To: <200602281604_MC3-1-B984-EC14@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602282209.04347.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 February 2006 22:01, Chuck Ebbert wrote:
> When x86_64 timer init messages were changed to use apic verbosity
> levels, two messages were missed and one got the wrong level. This
> causes the last word of a suppressed message to print on a line
> by itself.  Fix that so either the entire message prints or none
> of it does.

Applied thanks - although I plan to kill most of check_timer soon anyways.
So don't put too much effort into it right now.

-Andi
