Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbULORsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbULORsb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 12:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbULORsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 12:48:31 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:44931 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S262418AbULORsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 12:48:24 -0500
Date: Wed, 15 Dec 2004 18:48:18 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Gene Heskett <gene.heskett@verizon.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: USB making time drift [was Re: dynamic-hz]
In-Reply-To: <200412151203.44679.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.53.0412151846370.27011@gockel.physik3.uni-rostock.de>
References: <20041213002751.GP16322@dualathlon.random>
 <200412142159.23488.gene.heskett@verizon.net> <20041215091741.GA16322@dualathlon.random>
 <200412151203.44679.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, I was going to do that, but forgive me, its not in the .config
> file as a setting.  So where do edit what to revert to 100hz's.

It's in line 5 of include/asm-i386/param.h:
# define HZ             1000            /* Internal kernel timer frequency */

(if you are on an i386 system). Just change that back to 100.

Tim
