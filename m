Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264069AbTDJPPB (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 11:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264070AbTDJPPB (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 11:15:01 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:51982 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S264069AbTDJPPA (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 11:15:00 -0400
Date: Thu, 10 Apr 2003 17:26:35 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: R S-P Chan <rspchan@dso.org.sg>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Does kbuild 2.5 support separate obj/src trees
Message-ID: <20030410152635.GA1577@mars.ravnborg.org>
Mail-Followup-To: R S-P Chan <rspchan@dso.org.sg>,
	linux-kernel@vger.kernel.org
References: <3E939034.8010106@dso.org.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E939034.8010106@dso.org.sg>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 09, 2003 at 11:15:00AM +0800, R S-P Chan wrote:
> Haven't been building kernels for a while but the Makefile contains
> srctree/objtree variables - so does kbuild 2.5 now support
> separate obj/src trees? Tks.

Not yet.
I have posted a patch enabling this a couple of times, but it has not
mainstream kernel yet :-(
There is people that request this feature, and it is doable - with some
annoying restrictions. The main issue is that the kernel src shall be
free of generated files when compiling for a separate objtree.
I got limited feedback on the implementataion so far.

The patch will most likely be updated during easter.

	Sam
