Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272875AbRIMGMa>; Thu, 13 Sep 2001 02:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272878AbRIMGMU>; Thu, 13 Sep 2001 02:12:20 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:23536 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S272875AbRIMGMN>; Thu, 13 Sep 2001 02:12:13 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Thu, 13 Sep 2001 00:12:18 -0600
To: Samium Gromoff <_deepfire@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS handling proposal
Message-ID: <20010913001218.E1541@turbolinux.com>
Mail-Followup-To: Samium Gromoff <_deepfire@mail.ru>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200109130611.f8D6BfV01791@vegae.deep.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200109130611.f8D6BfV01791@vegae.deep.net>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 13, 2001  06:11 +0000, Samium Gromoff wrote:
>         Hello folks!
>     People most likely needs first oops most of the time, so
>   it would be great to make a kernel boot option to stop after
>   first oops, so in the situations when its neede life can be made easy.
>     Actually afaics this is being done each time by hand, so 
>   panic() in BUG() as Rik proposed would be nice.
>     What do you folks think?

Absolutely NOT.  If you panic() in BUG() then you DO have to copy the oops
by hand each time, whereas the normal situation is that you can keep
running after an oops - to decode it, see what the symptoms are, check
memory, etc.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

