Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264643AbUEYMgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264643AbUEYMgj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 08:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264646AbUEYMgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 08:36:39 -0400
Received: from colin2.muc.de ([193.149.48.15]:34309 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264643AbUEYMgi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 08:36:38 -0400
Date: 25 May 2004 14:36:36 +0200
Date: Tue, 25 May 2004 14:36:36 +0200
From: Andi Kleen <ak@muc.de>
To: Malte Schr?der <MalteSch@gmx.de>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
Subject: Re: Bad X-performance on 2.6.6 & 2.6.7-rc1 on x86-64
Message-ID: <20040525123636.GA13817@colin2.muc.de>
References: <1ZqbC-5Gl-13@gated-at.bofh.it> <m3r7t9d3li.fsf@averell.firstfloor.org> <20040525122659.395783f4@highlander.Home.LAN>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040525122659.395783f4@highlander.Home.LAN>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 12:26:59PM +0200, Malte Schr?der wrote:
> New information :)
> I didn't profile it yet but I think I found what caused the problem.
> It turned out that I have to disable alsa mmap-support in xine (mplayer worked w/o problems, it does not offer alsa mmap), so X is not involved at all. Do you still need a profile or is this a known thing?

Ask the xine guys if it's known, I don't know much about xine.
If a user space change fixes it then I don't need any profiles.

-Andi
