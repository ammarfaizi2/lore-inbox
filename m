Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289549AbSAONx7>; Tue, 15 Jan 2002 08:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289577AbSAONxt>; Tue, 15 Jan 2002 08:53:49 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:47611 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S289549AbSAONxk>; Tue, 15 Jan 2002 08:53:40 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <a1vu5q$1uu$1@cesium.transmeta.com> 
In-Reply-To: <a1vu5q$1uu$1@cesium.transmeta.com>  <20020114125228.B14747@thyrsus.com> <20020114223042.ENDG28486.femail48.sdc1.sfba.home.com@there> <20020114173423.A23081@thyrsus.com> <20020115080218.7709cef7.bruce@ask.ne.jp> 
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution) 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 15 Jan 2002 13:53:32 +0000
Message-ID: <12322.1011102812@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hpa@zytor.com said:
>   If we have designed our kernels so that:
	<...>
> b) It's not possible to add a driver without rebuilding the kernel,
> or;
	<...>
> then we have screwed up. 

Oops. In that case, we screwed up (130 - delta) times.

find /usr/src/linux/ -name \*.[ch] | xargs egrep \#if.*CONFIG_.*_MODULE |  cut -f2- -d: | sort | uniq | wc -l

--
dwmw2


