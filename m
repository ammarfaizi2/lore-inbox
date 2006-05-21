Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751501AbWEUK0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbWEUK0p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 06:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWEUK0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 06:26:45 -0400
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:25533 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932366AbWEUK0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 06:26:44 -0400
Date: Sun, 21 May 2006 03:26:42 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Haar J?nos <djani22@netcenter.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swapper: page allocation failure.
Message-ID: <20060521102642.GB5582@taniwha.stupidest.org>
References: <00e901c67cad$fe9a9d90$1800a8c0@dcccs> <20060521081621.GA1151@taniwha.stupidest.org> <010801c67cb1$bc13fd00$1800a8c0@dcccs> <20060521084728.GA2535@taniwha.stupidest.org> <012201c67cb5$7a213800$1800a8c0@dcccs> <20060521091022.GA3468@taniwha.stupidest.org> <014601c67cb9$4f235f30$1800a8c0@dcccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <014601c67cb9$4f235f30$1800a8c0@dcccs>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2006 at 11:31:12AM +0200, Haar J?nos wrote:

> [root@st-0001 /]# uname -a
> Linux st-0001 2.6.17-rc3-git1 #2 SMP Sun May 21 01:12:22 CEST 2006 i686 i686 i386 GNU/Linux

did earlier kernels work OK?

> This is a simple disk node.
> It serves the md0 array, and uses mem for buffering-caching.

odd, i looks like you've leaked alot of lowmem but i can't think why

i've got major (induced) brain-fog right now so i'll have to think
about it tomorrow sorry
