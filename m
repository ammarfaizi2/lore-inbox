Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267098AbUBEX6f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 18:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267097AbUBEX6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 18:58:35 -0500
Received: from www.piratehaven.org ([204.253.162.40]:32224 "EHLO
	skull.piratehaven.org") by vger.kernel.org with ESMTP
	id S267096AbUBEX6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 18:58:33 -0500
Date: Thu, 5 Feb 2004 15:58:32 -0800
From: Dale Harris <rodmur@maybe.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.24, ACPI, hyperthreading and strange messages
Message-ID: <20040205235832.GB3330@maybe.org>
Mail-Followup-To: Dale Harris <rodmur@maybe.org>,
	linux-kernel@vger.kernel.org
References: <20040205230434.GC27523@maybe.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040205230434.GC27523@maybe.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 03:04:34PM -0800, Dale Harris elucidated:
> 
> Howdie,
> 
> I'm seeing some usual messages from dmesg with a kernel that I have
> running on a cluster.  I have hyperthreading capable Xeons, Supermicro
> mobos, and the nodes have LinuxBIOS (but the mayor does not).  I had to
> bump the CONFIG_NR_CPUS to 8 to be able to even see both CPUs on the
> nodes.  The messages I see that concern me are:
> 


Just for completeness, below is the differences between my kernel and
2.4.24 vanilla:

http://research.amnh.org/users/rodmur/bproc.patch


--
Dale Harris   
rodmur@maybe.org
/.-)
