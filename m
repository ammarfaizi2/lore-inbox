Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316221AbSFDEaB>; Tue, 4 Jun 2002 00:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316243AbSFDEaA>; Tue, 4 Jun 2002 00:30:00 -0400
Received: from tomts9.bellnexxia.net ([209.226.175.53]:1705 "EHLO
	tomts9-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S316221AbSFDE37>; Tue, 4 Jun 2002 00:29:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ghozlane Toumi <ghoz@sympatico.ca>
To: "J.A. Magallon" <jamagallon@able.es>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Algorithm for CPU_X86
Date: Tue, 4 Jun 2002 00:28:53 -0400
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020604031840.GA4289@werewolf.able.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020604043000.DXEU21842.tomts9-srv.bellnexxia.net@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 June 2002 23:18, J.A. Magallon wrote:
> Hi all...
> So the algorithm can be easy (i think..)
> - Enable all feature flags (say, MMX and 3DNOW)
> - Disable all bugfix flags (FENCE)
> - For each CPU
>      if it does not have the feature, kill it
>      (if VENDOR_INTEL set 3DNOW=n)
>      if this-cpu-kernel could run on buggy-cpu, enable fix
>      (if GENERIC_586 set FENCE=y)
>
> Right ?

What if the next wizz-bang processor as a great new feature ?
You'd have to disable it for *all* the previous CPUs...

ghoz
