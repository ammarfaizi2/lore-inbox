Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263109AbTJONDh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 09:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263114AbTJONDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 09:03:37 -0400
Received: from holomorphy.com ([66.224.33.161]:11669 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263109AbTJONDf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 09:03:35 -0400
Date: Wed, 15 Oct 2003 06:06:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: jbglaw@lug-owl.de
Subject: Re: Unbloating the kernel, was: :mem=16MB laptop testing
Message-ID: <20031015130645.GJ765@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, jbglaw@lug-owl.de
References: <20031014143047.GA6332@ncsu.edu> <Pine.LNX.4.44.0310141813320.1776-100000@gaia.cela.pl> <20031015114514.GC20846@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031015114514.GC20846@lug-owl.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-10-14 18:27:05 +0200, Maciej Zenczykowski <maze@cela.pl>
> wrote in message <Pine.LNX.4.44.0310141813320.1776-100000@gaia.cela.pl>:
>> errnum->string. I'd expect that between 10-15% of the uncompressed kernel 
>> is currently pure text.

On Wed, Oct 15, 2003 at 01:45:14PM +0200, Jan-Benedict Glaw wrote:
> Right. For a real lowmem system (4MB RAM) I defined printk to a no-op
> and gained 90K at the compressed image IIRC. This was 2.2.x, though.
> MfG, JBG

The compressed image is hard to predict a runtime effect from; what did
it do to reserved memory at boot-time?


-- wli
