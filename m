Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317725AbSFLPaS>; Wed, 12 Jun 2002 11:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317726AbSFLPaR>; Wed, 12 Jun 2002 11:30:17 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:28172 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S317725AbSFLPaQ>; Wed, 12 Jun 2002 11:30:16 -0400
Date: Wed, 12 Jun 2002 16:36:35 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Thunder from the hill <thunder@ngforever.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.21: kbuild changes broke filenames with commas
Message-ID: <20020612163635.D22429@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20020611122144.A3665@flint.arm.linux.org.uk> <Pine.LNX.4.44.0206110611590.24261-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2002 at 06:16:10AM -0600, Thunder from the hill wrote:
> If we allow commas all over the filesystem and likewise say that there is 
> nothing to mention about it why should we refuse them for kbuild 
> especially since there is a parallel system which allows commas?

Aehm, if you argument with what we allow in the filesystem, then
I could argue, that everything except '\0' and '/' is allowed
to build paths.

Interesting is what the C-Standard says about naming conventions
for files.

The rest is merely taste and limitations of the build system.

I like ',' as much as ' ' and quotes in file names. But sh*t
happens and we usally have to cope with it :-/

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
