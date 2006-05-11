Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965115AbWEKBV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965115AbWEKBV1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 21:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965114AbWEKBV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 21:21:27 -0400
Received: from ozlabs.org ([203.10.76.45]:42154 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965111AbWEKBV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 21:21:26 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17506.37259.755099.974824@cargo.ozlabs.ibm.com>
Date: Thu, 11 May 2006 11:21:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alan Modra <amodra@bigpond.net.au>
Cc: "David S. Miller" <davem@davemloft.net>, linux-arch@vger.kernel.org,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, rth@twiddle.net
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
In-Reply-To: <20060511010438.GE24458@bubble.grove.modra.org>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
	<20060510154702.GA28938@twiddle.net>
	<20060510.124003.04457042.davem@davemloft.net>
	<17506.21908.857189.645889@cargo.ozlabs.ibm.com>
	<20060511010438.GE24458@bubble.grove.modra.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Modra writes:

> gcc shouldn't think there is any reason to cache the address.

Can I rely on that being true in the future?

Paul.
