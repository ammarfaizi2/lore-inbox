Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317987AbSGPUXt>; Tue, 16 Jul 2002 16:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317990AbSGPUXs>; Tue, 16 Jul 2002 16:23:48 -0400
Received: from ns.suse.de ([213.95.15.193]:8723 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317987AbSGPUXs>;
	Tue, 16 Jul 2002 16:23:48 -0400
Date: Tue, 16 Jul 2002 22:26:40 +0200
From: Andi Kleen <ak@suse.de>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Second x86-64 kernel snapshot based on 2.4.19rc1 released
Message-ID: <20020716222640.A10397@wotan.suse.de>
References: <20020716220302.A5400@wotan.suse.de> <3D347F9B.58740355@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D347F9B.58740355@nortelnetworks.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2002 at 04:18:35PM -0400, Chris Friesen wrote:
> Andi Kleen wrote:
> 
> > - vsyscalls are currently disabled because they trigger too many linker bugs together
> > with HPET timers. The vsyscall pages just call normal syscalls.
> 
> I assume that the linker is going to get fixed before general x86-64 release so
> these can be used together?

Yes, the problem is being worked on.

-Andi
