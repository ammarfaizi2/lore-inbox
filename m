Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbTESIko (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 04:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbTESIko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 04:40:44 -0400
Received: from landfill.ihatent.com ([217.13.24.22]:32128 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id S261489AbTESIkn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 04:40:43 -0400
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Dave Jones <davej@codemonkey.org.uk>, Andrew Morton <akpm@digeo.com>,
       "" <linux-kernel@vger.kernel.org>, "" <linux-mm@kvack.org>
Subject: Re: [OOPS] 2.5.69-mm6
References: <20030516015407.2768b570.akpm@digeo.com>
	<87fznfku8z.fsf@lapper.ihatent.com>
	<20030516180848.GW8978@holomorphy.com>
	<20030516185638.GA19669@suse.de>
	<20030516191711.GX8978@holomorphy.com>
	<Pine.LNX.4.50.0305162322360.2023-100000@montezuma.mastecende.com>
	<Pine.LNX.4.50.0305170937350.1910-100000@montezuma.mastecende.com>
	<87u1brbazl.fsf@lapper.ihatent.com>
	<Pine.LNX.4.50.0305190431130.28750-100000@montezuma.mastecende.com>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 19 May 2003 10:53:56 +0200
In-Reply-To: <Pine.LNX.4.50.0305190431130.28750-100000@montezuma.mastecende.com>
Message-ID: <873cjbjp0b.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Zwane Mwaikambo <zwane@linuxpower.ca> writes:

> On Mon, 19 May 2003, Alexander Hoogerhuis wrote:
> 
> > Once I compile DRM/AGP as non-modular all errors are gone:
> 
> Aargh.. Can you try recompile inkernel and reproduce again?
> 

That's the problem, I've rekompiled the whole thing, with AGO/DRM in
kernel (non-modular), and the errors are gone... I'm not even seeing
the the usual radeon error like this one:

[drm] Initialized radeon 1.8.0 20020828 on minor 0
[drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
[drm:radeon_unlock] *ERROR* Process 4793 using kernel context 0

> 	Zwane

mvh,
A
- -- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+yJuhCQ1pa+gRoggRAvb0AJ44hHuACwDfIcjKOu8bPUJhnvztGwCgvKsK
kZ7i7Sd+WImIwyP7D05vCSU=
=C1gX
-----END PGP SIGNATURE-----
