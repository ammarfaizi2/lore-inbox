Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314389AbSFJR5R>; Mon, 10 Jun 2002 13:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315607AbSFJR5Q>; Mon, 10 Jun 2002 13:57:16 -0400
Received: from ns.suse.de ([213.95.15.193]:56586 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S314389AbSFJR5P>;
	Mon, 10 Jun 2002 13:57:15 -0400
Date: Mon, 10 Jun 2002 19:57:15 +0200
From: Dave Jones <davej@suse.de>
To: Clemens Schwaighofer <cs@pixelwings.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20-dj4 oss broken.
Message-ID: <20020610195715.Z13140@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Clemens Schwaighofer <cs@pixelwings.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0206101940280.13641-100000@lynx.piwi.intern>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 07:42:16PM +0200, Clemens Schwaighofer wrote:
 > ac97_codec.c:116: label ad1886_ops referenced outside of any function

Typo. There is a && at the end of that line which should just be a
single &

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
