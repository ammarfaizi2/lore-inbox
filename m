Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbTJHNNW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 09:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbTJHNNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 09:13:22 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:35992 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S261476AbTJHNNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 09:13:21 -0400
Date: Wed, 8 Oct 2003 15:13:20 +0200
From: ookhoi@humilis.net
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: why does netfilter make upload very slow? (was: Re: e1000 -> 82540EM on linux 2.6.0-test[45] very slow in one direction)
Message-ID: <20031008131320.GD16964@favonius>
Reply-To: ookhoi@humilis.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Uptime: 12:10:55 up 120 days, 12:12, 37 users,  load average: 2.11, 2.02, 2.46
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ookhoi wrote (ao):
# Ookhoi wrote (ao):
# > Florian Zwoch wrote (ao):
# > > issue seems to partly solved. the e1000 driver seems to be ok!
# > > i reconfigured my kernel and intentionally left out netfilter options. 
# > > after that my network performance was back to normal.
# > > 
# > > netfilter was only compiled in the kernel. it was not used with any rules!
# > > 
# > > so my wild guess would be that something with the netfilter code (i am 
# > > not 100% sure it was netfilter.. _maybe_ it was some small odd kernel 
# > > option i accidently enabled/disabled) is broken since test3 (again 
# > > uncertified. but i firstly noticed this switching from test3 to test4).
# 
# > I have netfilter enabled, and will try another -test6 kernel with
# > netfilter not compiled in to see if that indeed makes a difference.
# 
# I can confirm now that disabling netfilter in 2.6.0-test6 makes the nic
# perform oke wrt upload.
# I (just like Florian) had no iptables rules active in the former
# 2.6.0-test6 kernel, but netfilter was compiled in.

Would somebody like to explain why netfilter (in kernel, but not in use)
makes upload go very slow? I am by no means a network guru, but eager to
learn :-)
