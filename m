Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbUCXAlg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 19:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbUCXAlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 19:41:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43732 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262945AbUCXAlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 19:41:32 -0500
Date: Tue, 23 Mar 2004 19:41:10 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Kurt Garloff <garloff@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Non-Exec stack patches
In-Reply-To: <20040323164104.11d79f32.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0403231940200.25882@devserv.devel.redhat.com>
References: <20040323231256.GP4677@tpkurt.garloff.de> <20040323154937.1f0dc500.akpm@osdl.org>
 <20040324002149.GT4677@tpkurt.garloff.de> <20040323164104.11d79f32.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 23 Mar 2004, Andrew Morton wrote:

> Now, what should the kernel do if the executable requests
> EXSTACK_DISABLE_X but the kernel cannot do that?  Is it not a bit
> misleading/dangerous to permit the executable to run anyway?

it's not really a problem. We already ignore the !X bit on x86.

	Ingo
