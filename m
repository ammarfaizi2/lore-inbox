Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290684AbSBLBMW>; Mon, 11 Feb 2002 20:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290675AbSBLBMM>; Mon, 11 Feb 2002 20:12:12 -0500
Received: from dsl-65-185-109-125.telocity.com ([65.185.109.125]:20611 "EHLO
	ohdarn.net") by vger.kernel.org with ESMTP id <S290688AbSBLBMD>;
	Mon, 11 Feb 2002 20:12:03 -0500
Subject: Re: paching 2.5.4 to -pre6???
From: Michael Cohen <me@ohdarn.net>
To: linux-kernel@vger.kernel.org
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
In-Reply-To: <Pine.LNX.4.30.0202111222240.27823-100000@mustard.heime.net>
In-Reply-To: <Pine.LNX.4.30.0202111222240.27823-100000@mustard.heime.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 11 Feb 2002 20:12:01 -0500
Message-Id: <1013476321.26192.2.camel@ohdarn.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-02-11 at 06:28, Roy Sigurd Karlsbakk wrote:
> hi all
> 
> Is there something wrong with the -pre6 patch?
> 
> I'm trying to patch up the 2.5.4...
> 
> # tar xzf ../packed/k/linux-2.5.4.tar.gz
> # cd linux-2.4.5
> # zcat ../../packed/k/patch-2.5.4-pre6.gz | patch -p1
pre6 is already included in 2.5.4.
The next patch that applies to 2.5.4 will be 2.5.5-pre1.

> patching file CREDITS
> Reversed (or previously applied) patch detected!  Assume -R? [n]
> and so on... patch -p1 -R gives me some hunks, but generally works ...
Yes, because you're backing out 2.5.4-pre6's changes. not a good idea.
Just leave the 2.5.4 tarball alone for now.

