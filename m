Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282905AbRLKUXn>; Tue, 11 Dec 2001 15:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283592AbRLKUXZ>; Tue, 11 Dec 2001 15:23:25 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:65258 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S283675AbRLKUXU>; Tue, 11 Dec 2001 15:23:20 -0500
Date: Tue, 11 Dec 2001 15:23:20 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Wayne Whitney <whitney@math.berkeley.edu>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17-pre8 OOPS with RedHat gcc 3.1-0.10
Message-ID: <20011211152319.D6878@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0112102048390.17524-100000@mf1.private> <Pine.LNX.4.33.0112111139460.18171-100000@mf1.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112111139460.18171-100000@mf1.private>; from whitney@math.berkeley.edu on Tue, Dec 11, 2001 at 11:51:41AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2001 at 11:51:41AM -0800, Wayne Whitney wrote:
> On Mon, 10 Dec 2001, Wayne Whitney wrote:
> 
> > I recently upgraded to "gcc version 3.1 20011127 (Red Hat Linux
> > Rawhide 3.1-0.10)".  It compiles the recent 2.4.17-preX kernels
> 
> Well, it compiles them, but I get an oops on booting 2.4.17-pre8, for
> example, almost immediately after init is launched.  "gcc version 2.96
> 20000731 (Red Hat Linux 7.2 2.96-101.9)" works fine.

This looks like a gcc bug.  Could you disassemble the entirety of do_signal 
and submit that plus the original source as a bug report against gcc in 
Red Hat's bugzilla?  Thanks,

		-ben
