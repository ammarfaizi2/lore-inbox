Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281565AbRKUKV4>; Wed, 21 Nov 2001 05:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281692AbRKUKVi>; Wed, 21 Nov 2001 05:21:38 -0500
Received: from mo.kasei.com ([212.250.176.40]:36102 "HELO soto.kasei.com")
	by vger.kernel.org with SMTP id <S281563AbRKUKVV>;
	Wed, 21 Nov 2001 05:21:21 -0500
Date: Wed, 21 Nov 2001 10:21:19 +0000
From: Marty Pauley <kernel@kasei.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.15pre6: CONFIG_APM=m causes hangup on boot
Message-ID: <20011121102119.A24895@soto.kasei.com>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.30.0111202035080.19555-100000@balu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.30.0111202035080.19555-100000@balu>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Nov 20 20:48:30 2001, Pozsar Balazs wrote:
> I've just been playing with config possibilities and found that if i
> compile a kernel with CONFIG_APM=m it hangs during boot (see bootlog).
> If i choose CONFIG_APM=y everything works well except that i cannot use
> acpi since apm is initialized first (btw, why?? -> i would rahter use acpi
> if both are available).

Pass 'apm=off' to Linux when you are booting: apm will not be started
and acpi will take its place.

-- 
Marty
