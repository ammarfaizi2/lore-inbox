Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263120AbTJONHN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 09:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbTJONHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 09:07:12 -0400
Received: from holomorphy.com ([66.224.33.161]:12437 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263120AbTJONHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 09:07:09 -0400
Date: Wed, 15 Oct 2003 06:10:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: jbglaw@lug-owl.de
Subject: Re: Unbloating the kernel, action list
Message-ID: <20031015131015.GR16158@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, jbglaw@lug-owl.de
References: <HMQWM7$61FA432C2B793029C11F4F77EEAABD1F@libero.it> <20031014214311.GC933@inwind.it> <16710000.1066170641@flay> <20031014155638.7db76874.cliffw@osdl.org> <20031015124842.GE20846@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031015124842.GE20846@lug-owl.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-10-14 15:56:38 -0700, cliff white <cliffw@osdl.org>
>> Marco, if you could supply time on a small client box, and a desired .config,
>> we can add you as a Tinderbox client,
>>  then you have a place to point people when the size increases. 

On Wed, Oct 15, 2003 at 02:48:42PM +0200, Jan-Benedict Glaw wrote:
> I can put on the table:
> 486SLC, 12MB RAM
> i386, 8MB RAM (hey, this box is nearly build up by discrete parts:)
> Am386, 8MB RAM
> P-Classic, 32MB RAM (even that much RAM can go short after an uptme of
> about a month...)
> Unfortunately, you need an additional kernel patch because nearly all
> distros are using mach==i486 which gives you nice sigills on an i386
> otherwise...
> MfG, JBG

Can you quantify the performance impact of cmov emulation (or whatever
it is)? I have a vague notion it could be hard given the daunting task
of switching userspace around to verify it.


-- wli
