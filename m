Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263579AbSIQEOB>; Tue, 17 Sep 2002 00:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263583AbSIQEOA>; Tue, 17 Sep 2002 00:14:00 -0400
Received: from m029-045.nv.iinet.net.au ([203.217.29.45]:46819 "EHLO localhost")
	by vger.kernel.org with ESMTP id <S263579AbSIQEOA>;
	Tue, 17 Sep 2002 00:14:00 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: To Anyone with a Radeon 7500 board and the ali developer
References: <1032180131.1191.7.camel@irongate.swansea.linux.org.uk>
	<20020916.121423.109699832.davem@redhat.com>
	<8765x5z9go.fsf@enki.rimspace.net>
	<20020916.182924.50846771.davem@redhat.com>
In-Reply-To: <20020916.182924.50846771.davem@redhat.com> ("David S.
 Miller"'s message of "Mon, 16 Sep 2002 18:29:24 -0700 (PDT)")
From: Daniel Pittman <daniel@rimspace.net>
Organization: Not today, thank you, Mother.
Date: Tue, 17 Sep 2002 14:18:55 +1000
Message-ID: <87znuhxn80.fsf@enki.rimspace.net>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.5 (bamboo,
 i686-pc-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2002, David S. Miller wrote:
>    From: Daniel Pittman <daniel@rimspace.net>
>    Date: Tue, 17 Sep 2002 11:33:11 +1000
> 
>    ...which might explain why my machine has occasional DRM related
>    hangs, since there is no way for me to match the XFree86 AGP speed
>    and the BIOS set AGP speed -- my BIOS will not tell me what it set,
>    nor does it have a toggle to adjust it.
> 
> There's a value in the PCI config space, check out the AGP gart
> code in the kernel.  I don't know it offhand.

lspci -vv shows the details of it, in case anyone else is wondering what
their AGP bridge is configured for. Now to see if that solves my DRI
hangs...

        Daniel

-- 
A psychatrist is someone who hopefully finds out what
makes a person tick before they explode.
        -- Alfred E. Neuman
