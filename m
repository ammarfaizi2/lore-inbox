Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262180AbTDAIPR>; Tue, 1 Apr 2003 03:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262181AbTDAIPR>; Tue, 1 Apr 2003 03:15:17 -0500
Received: from modemcable226.131-200-24.mtl.mc.videotron.ca ([24.200.131.226]:48123
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262180AbTDAIPQ>; Tue, 1 Apr 2003 03:15:16 -0500
Date: Tue, 1 Apr 2003 03:22:19 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Andi Kleen <ak@suse.de>, Dave Jones <davej@suse.de>
Subject: Re: [PATCH][2.5][RFT] sfence wmb for K7,P3,VIAC3-2(?)
In-Reply-To: <Pine.LNX.4.50.0304010242250.8773-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0304010320220.8773-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0304010242250.8773-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Apr 2003, Zwane Mwaikambo wrote:

> +config X86_SSE
> +	bool
> +	depends on MK7 || MPENTIUMIII || MVIAC3_2
> +	default y
> +

Bad option to flag against as pointed out by someone, seeing as K7 
implimented half the SSE instructions.

urgh...

-- 
function.linuxpower.ca
