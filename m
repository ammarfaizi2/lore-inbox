Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262895AbREVXnu>; Tue, 22 May 2001 19:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262898AbREVXnk>; Tue, 22 May 2001 19:43:40 -0400
Received: from ns.suse.de ([213.95.15.193]:14862 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S262895AbREVXnc>;
	Tue, 22 May 2001 19:43:32 -0400
Date: Wed, 23 May 2001 01:43:30 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: <ttel5535@artax.karlin.mff.cuni.cz>
Cc: "H. Peter Anvin" <hpa@transmeta.com>, <linux-kernel@vger.kernel.org>,
        "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
Subject: Re: [Patch] Output of L1,L2 and L3 cache sizes to /proc/cpuinfo
In-Reply-To: <Pine.LNX.4.21.0105230032440.31122-100000@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.30.0105230142140.20489-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 May 2001, Tomas Telensky wrote:

> > Any particular reason this needs to be done in the kernel, as opposed
> It is already done in kernel, because it's displaying :)
> So, once evaluated, why not to give it to /proc/cpuinfo. I think it makes
> sense and gives it things in order.

Displaying at boottime only means the function can be marked as initcode,
and freed after usage. Putting it in proc/cpuinfo means we use up
kernel space that can't be freed.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

