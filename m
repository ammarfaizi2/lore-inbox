Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbTISUnq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 16:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbTISUnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 16:43:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:16812 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261743AbTISUnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 16:43:43 -0400
Date: Fri, 19 Sep 2003 13:36:48 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Will Dyson <will_dyson@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [CFT] [1/15] table-driven filesystems option parsing
Message-Id: <20030919133648.400ad18e.rddunlap@osdl.org>
In-Reply-To: <1063826464.17972.897.camel@thalience>
References: <20030905115615.283cab00.rddunlap@osdl.org>
	<1063826464.17972.897.camel@thalience>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Sep 2003 15:21:05 -0400 Will Dyson <will_dyson@pobox.com> wrote:

| On Fri, 2003-09-05 at 14:56, Randy.Dunlap wrote:
| 
| > Current (full) patch is at
| > http://developer.osdl.org/rddunlap/patches/linux-260t4g-fsoptions.patch
| > 
| > These patches apply to 2.6.0-test4 or -current (Sept. 5/2003).
| > 
| > I have tested ext3, ext3, fat, isofs, jfs, & proc.
| > 
| > I'd appreciate others testing all of these, please, especially
| > the ones that I can't test (adfs, affs, hfs, hpfs, ufd, ufs,
| > autofs[4]).
| 
| As a filesystem maintainer, I like the idea of this patch! However, I
| think it could use some comments on useage in the header file. There are
| already too many filesystem interfaces where the only documentation on
| how to use them is the way that existing filesystems use them.
| 
| Below is a patch to convert befs to use parser.h. It kills some of my
| least favorite code (yay!).
| 
| The patch is tested a certain minimal amount (booted, mounted a
| filesystem with options).

Thanks for the patch and comments.  I'll try to add some usage docs
to it also.

--
~Randy
