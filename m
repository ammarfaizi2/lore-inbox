Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263313AbUJ2NSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263313AbUJ2NSp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 09:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbUJ2NSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 09:18:45 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:51972 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263313AbUJ2NPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 09:15:10 -0400
Date: Fri, 29 Oct 2004 14:14:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Rahul Karnik <deathdruid@gmail.com>
Cc: Nathan Scott <nathans@sgi.com>,
       Martin MOKREJ? <mmokrejs@ribosome.natur.cuni.cz>, linux-xfs@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: best linux kernel with memory management
Message-ID: <20041029131455.GA12382@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rahul Karnik <deathdruid@gmail.com>, Nathan Scott <nathans@sgi.com>,
	Martin MOKREJ? <mmokrejs@ribosome.natur.cuni.cz>,
	linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
References: <412C87F3.2030602@ribosome.natur.cuni.cz> <20040825114005.GB13285@logos.cnet> <412C94F5.4010902@ribosome.natur.cuni.cz> <20040825120450.GA22509@logos.cnet> <412C9D9C.6060703@ribosome.natur.cuni.cz> <20040827121905.GG32707@logos.cnet> <417F6258.7010209@ribosome.natur.cuni.cz> <20041028105108.GB5741@logos.cnet> <20041029071429.GF1246@frodo> <5b64f7f04102906084b358d5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b64f7f04102906084b358d5f@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 09:08:49AM -0400, Rahul Karnik wrote:
> On Fri, 29 Oct 2004 17:14:29 +1000, Nathan Scott <nathans@sgi.com> wrote:
> 
> > There should be no problems using XFS for everything, including
> > /boot - I do that on all my systems (for a few years now).
> 
> Last time I checked (~ 2 months ago), there is a GRUB bug that
> prevents the use of XFS as the /boot filesystem. I use ext3 for my
> /boot to get around this, with all my other filesystems being XFS. Any
> chance the XFS devs could help fix the GRUB team fix the bug?

they just have to remove the broken pass where they try to read from the
raw device. 
