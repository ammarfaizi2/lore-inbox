Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292030AbSBOAWx>; Thu, 14 Feb 2002 19:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292027AbSBOAWn>; Thu, 14 Feb 2002 19:22:43 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:58116 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S292021AbSBOAWc>;
	Thu, 14 Feb 2002 19:22:32 -0500
Date: Thu, 14 Feb 2002 22:22:17 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: <ccroswhite@get2chip.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Problems with VM
In-Reply-To: <3C6C53C0.E7562704@get2chip.com>
Message-ID: <Pine.LNX.4.33L.0202142221250.12554-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2002 ccroswhite@get2chip.com wrote:

> I am having difficulties with memory allocation in  teh 2.4.17 kernel.
> Memory is being agressively given as cache but not retrieved to be used
> as 'normal' ran.  Consequently, I will have a machine that has 5M
> 'normal' RAM, 800M 'cache' RAM and the reset coming out of swap space.
> I need this 'cache' RAM placed back into the available RAM pool to be
> used by applications.  Is there a patch/kernel configuration that I can
> change this behavior?

If you feel adventurous, you could try my reverse mapping VM:

http://surriel.com/patches/2.4/2.4.17-rmap-12f


The changelog can be found at http://surriel.com/patches/Changelog.rmap

kind regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

