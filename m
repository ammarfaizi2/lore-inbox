Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263307AbUCNGd6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 01:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbUCNGd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 01:33:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26589 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263307AbUCNGd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 01:33:56 -0500
Date: Sat, 13 Mar 2004 22:33:49 -0800
From: "David S. Miller" <davem@redhat.com>
To: Ron Peterson <rpeterso@mtholyoke.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: network/performance problem
Message-Id: <20040313223349.3dcbfb61.davem@redhat.com>
In-Reply-To: <20040312225606.GA19722@mtholyoke.edu>
References: <20040311152728.GA11472@mtholyoke.edu>
	<20040311151559.72706624.akpm@osdl.org>
	<20040311233525.GA14065@mtholyoke.edu>
	<20040312164704.GA17969@mtholyoke.edu>
	<20040312225606.GA19722@mtholyoke.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2004 17:56:06 -0500
Ron Peterson <rpeterso@mtholyoke.edu> wrote:

> ...just in case ...since my sense of humor is suspect ...that was a
> joke.  Same problem persists after reboot.  I haven't installed a
> different kernel or otherwise changed anything on 'sam' yet.  Not sure
> what would be good to try next.

FInd out what's adding all of the netfilter rules like crazy.

It is obvious this is happening, from your profiles.  I know you
say that you have no idea what might be doing it, but your description
matches every other one that was reported in the past of gradual
networking slowdown, and in each of those cases it was something
poking netfilter in some way, and your profiles basically
confirm that this is what is happening somehow on your box.

