Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281453AbRKPPum>; Fri, 16 Nov 2001 10:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281454AbRKPPuc>; Fri, 16 Nov 2001 10:50:32 -0500
Received: from zero.tech9.net ([209.61.188.187]:2054 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S281453AbRKPPuW>;
	Fri, 16 Nov 2001 10:50:22 -0500
Subject: Re: Insanely high "Cached" value
From: Robert Love <rml@tech9.net>
To: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        akpm@zip.com.au
In-Reply-To: <3BF4E24D.2E7567A7@TeraPort.de>
In-Reply-To: <3BF4E24D.2E7567A7@TeraPort.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 16 Nov 2001 10:50:17 -0500
Message-Id: <1005925819.901.2.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-11-16 at 04:54, Martin Knoblauch wrote:
>  Hmm. Are you sure it is ext3 only? I see the same (coming and going, no
> real harm) on 2.4.13-ac4+preempt without having EXT3 enabled. Also
> happens with 2.4.13 plain.

It is not preempt-kernel's fault.  There are two separate bugs, one in
ext3 and one in the cache reporting in -ac series.  Newer kernels fix
both problems.

2.4.13-ac7 and 2.4.15-pre5 are not affected ... 2.4.15-pre5 is probably
ideal, it merged ext3, too.

	Robert Love

