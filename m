Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316786AbSE0XkI>; Mon, 27 May 2002 19:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316788AbSE0XkH>; Mon, 27 May 2002 19:40:07 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:63220 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316786AbSE0XkG>; Mon, 27 May 2002 19:40:06 -0400
Subject: Re: [RFC] arch names
From: Robert Love <rml@tech9.net>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020527150700.GE6738@werewolf.able.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 27 May 2002 16:39:48 -0700
Message-Id: <1022542788.20312.27.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-05-27 at 08:07, J.A. Magallon wrote:

> After five minutes working on the arches patch, I realized that
> if PII gets split away, CONFIG_M686 only stands for PPro, so it
> would be worth a rename to CONFIG_MPENTIUMPRO ?

Yah, it would.  CONFIG_M686 is now too general - unless we want
CONFIG_M686 _and_ a specific arch, like CONFIG_MPII.  Then we can check
just the general case (M686) or the specific chip (MPII) as needed.

Also, CONFIG_MPPRO is easier on the eyes :)

> Only drawback is that people (ie - distros) could not just copy their old
> .config and build...

They should `make oldconfig' anyhow...

	Robert Love

