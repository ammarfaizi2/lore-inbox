Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265237AbTFRQhm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 12:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265167AbTFRQhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 12:37:42 -0400
Received: from holomorphy.com ([66.224.33.161]:19625 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265234AbTFRQhd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 12:37:33 -0400
Date: Wed, 18 Jun 2003 09:51:24 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: davidm@hpl.hp.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: O(1) scheduler starvation
Message-ID: <20030618165124.GJ26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	davidm@hpl.hp.com, LKML <linux-kernel@vger.kernel.org>
References: <1055922807.585.5.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055922807.585.5.camel@teapot.felipe-alfaro.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 09:53:28AM +0200, Felipe Alfaro Solana wrote:
> I'm running 2.5.72-mm1 with Mike Galbraith's scheduler patches and a
> small patch I made myself to improve interactivity (mainly, to stop XMMS
> from skipping by adjusting some scheduler parameters).
> What's going on here? Is the previous article outdated, or have the
> starvation problems been definitively fixed?

The MAX_TIMESLICE change is inappropriate.

There's papering over broken algorithms, and then there's getting really
blatant about it -- and MAX_TIMESLICE going from 200 -> 20 is blatant.


-- wli
