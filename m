Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270958AbRIFOV3>; Thu, 6 Sep 2001 10:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270992AbRIFOVT>; Thu, 6 Sep 2001 10:21:19 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:38917 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S270958AbRIFOVF>; Thu, 6 Sep 2001 10:21:05 -0400
Date: Thu, 6 Sep 2001 16:21:24 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Wietse Venema <wietse@porcupine.org>
Cc: Andrey Savochkin <saw@saw.sw.com.sg>, Andi Kleen <ak@suse.de>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
Subject: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
Message-ID: <20010906162124.D29583@maggie.dt.e-technik.uni-dortmund.de>
Mail-Followup-To: Wietse Venema <wietse@porcupine.org>,
	Andrey Savochkin <saw@saw.sw.com.sg>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010906173534.A21874@castle.nmd.msu.ru> <20010906140444.75DC1BC06C@spike.porcupine.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010906140444.75DC1BC06C@spike.porcupine.org>; from wietse@porcupine.org on Thu, Sep 06, 2001 at 10:04:44 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Sep 2001, Wietse Venema wrote:

> If Linux insists on breaking SIOCGIFCONF then so be it, even though
> it works perfectly well on any non-Linux system that I could lay
> my hands on.

Linux does not break SIOCGIFCONF as far as I can see, but
SIOCGIFNETMASK. Your inet_addr_local obtains all interfaces's addresses,
it just gets the wrong netmasks back.
