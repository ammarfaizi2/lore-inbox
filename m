Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262881AbUJ1Vu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbUJ1Vu6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 17:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263093AbUJ1Vqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 17:46:35 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:65141 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S263080AbUJ1Vp2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 17:45:28 -0400
Date: Fri, 29 Oct 2004 01:45:49 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       linux-arch@vger.kernel.org
Subject: Re: kbuild/all archs: Sanitize creating offsets.h
Message-ID: <20041028234549.GB17314@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
References: <20041028185917.GA9004@mars.ravnborg.org> <20041028204430.C11436@flint.arm.linux.org.uk> <20041028215959.GA17314@mars.ravnborg.org> <20041028220024.D11436@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028220024.D11436@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 10:00:24PM +0100, Russell King wrote:
> > Did you apply the patch that enabled kbuild files to be named Kbuild?
> > It looks like this patch is missing.
> 
> I applied three patches.  The first was "kbuild: Prefer Kbuild as name of
> the kbuild files"
> 
> > If you did apply the patch could you please check if the asm->asm-arm
> > symlink exists when the error happens and that a file named Kbuild is
> > located in the directory: include/asm-arm/

OK - I see it now.
It's in i386 also - I will have a fix ready tomorrow. Thanks for testing!

	Sam
