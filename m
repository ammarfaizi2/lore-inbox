Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbULNHqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbULNHqD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 02:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbULNHqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 02:46:03 -0500
Received: from news.suse.de ([195.135.220.2]:35743 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261443AbULNHqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 02:46:00 -0500
Date: Tue, 14 Dec 2004 08:45:54 +0100
From: Andi Kleen <ak@suse.de>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 32-bit syscalls from 64-bit process on x86-64?
Message-ID: <20041214074554.GK1046@wotan.suse.de>
References: <1102004520.8707.10.camel@localhost> <20041203061520.GG31767@wotan.suse.de> <1102115789.8707.122.camel@localhost> <20041204144002.GA15404@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041204144002.GA15404@vana.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> #define TOLM                            \
>                 "pushl %%cs\n"          \
>                 "pushl $91f\n"          \
>                 "ljmpl $0x33,$90f\n"    \

It's useless, there is nothing in the kernel code that checks the 
32bit segment.

-Andi
