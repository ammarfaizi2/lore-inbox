Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287532AbSAZJMw>; Sat, 26 Jan 2002 04:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289042AbSAZJMm>; Sat, 26 Jan 2002 04:12:42 -0500
Received: from khms.westfalen.de ([62.153.201.243]:691 "EHLO khms.westfalen.de")
	by vger.kernel.org with ESMTP id <S287532AbSAZJMa>;
	Sat, 26 Jan 2002 04:12:30 -0500
Date: 26 Jan 2002 09:24:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: ak@suse.de
cc: linux-kernel@vger.kernel.org
Message-ID: <8Hbnfxs1w-B@khms.westfalen.de>
In-Reply-To: <20020125231555.A22583@wotan.suse.de>
Subject: Re: [PATCH] Fix 2.5.3pre reiserfs BUG() at boot time
X-Mailer: CrossPoint v3.12d.kh8 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <20020125231555.A22583@wotan.suse.de>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ak@suse.de (Andi Kleen)  wrote on 25.01.02 in <20020125231555.A22583@wotan.suse.de>:

> +/* Must match cache_sizes above. Out of line to keep cache footprint low.
> */ +#define CN(x) { x, x ## "(DMA)" }
> +static char cache_names[][2][18] = {


> +	CN("size-128"),
> +	CN("size-256"),
> +	CN("size-512"),


What on earth is that ## for?! If that actually works, I strongly suspect  
that it is a bug in cpp.

MfG Kai
