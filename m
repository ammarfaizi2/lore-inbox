Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264364AbUBRKzW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 05:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264372AbUBRKzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 05:55:22 -0500
Received: from uslink-66.173.43-133.uslink.net ([66.173.43.133]:18437 "EHLO
	dingdong.cryptoapps.com") by vger.kernel.org with ESMTP
	id S264364AbUBRKzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 05:55:18 -0500
Date: Wed, 18 Feb 2004 02:55:08 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Klaus Ethgen <Klaus@Ethgen.de>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: TCP: Treason uncloaked DoS ??
Message-ID: <20040218105508.GA7320@dingdong.cryptoapps.com>
References: <20040218102725.GB3394@hathi.ethgen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040218102725.GB3394@hathi.ethgen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 11:27:25AM +0100, Klaus Ethgen wrote:

> Well I have the same every night when my backup on the local host is
> running. Many of the "kernel: TCP: Treason uncloaked! Peer
> 192.168.17.2:2988/33016 shrinks window 3035402428:3035418812. Repaired."

> But 192.168.17.2 is the same host! So the buggy TCP stack seams to
> be in linux kernel.

My guess is there is a PacketShaper in between mangling things.


  --cw
