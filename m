Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264122AbRFMQnb>; Wed, 13 Jun 2001 12:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264118AbRFMQnU>; Wed, 13 Jun 2001 12:43:20 -0400
Received: from firewall.ocs.com.au ([203.34.97.9]:4852 "EHLO ocs4.ocs-net")
	by vger.kernel.org with ESMTP id <S264122AbRFMQnO>;
	Wed, 13 Jun 2001 12:43:14 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Mark Mokryn <mark@sangate.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: SMP module compilation on UP? 
In-Reply-To: Your message of "Wed, 13 Jun 2001 16:42:54 +0300."
             <3B276DDE.A19F60DF@sangate.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 14 Jun 2001 02:42:59 +1000
Message-ID: <18688.992450579@ocs4.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2001 16:42:54 +0300, 
Mark Mokryn <mark@sangate.com> wrote:
>Is it possible to build an SMP module on a machine running a UP kernel
>(or vice versa)?

Build - yes.  Load - no.  Not unless you like your kernel exploding
into a million tiny pieces.  You can compile anything from anywhere,
you can even compile the kernel from other operating systems.  But
loading an SMP module into a UP system or vice versa guarantees data
mismatches.

