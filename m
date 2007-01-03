Return-Path: <linux-kernel-owner+w=401wt.eu-S1750743AbXACNEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbXACNEb (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 08:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbXACNEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 08:04:31 -0500
Received: from jabberwock.ucw.cz ([89.250.246.4]:56338 "EHLO jabberwock.ucw.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750743AbXACNEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 08:04:30 -0500
Date: Wed, 3 Jan 2007 13:45:11 +0100
From: Martin Mares <mj@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: pavel@ucw.cz, bhalevy@panasas.com, arjan@infradead.org,
       mikulas@artax.karlin.mff.cuni.cz, jaharkes@cs.cmu.edu,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       nfsv4@ietf.org
Subject: Re: Finding hardlinks
Message-ID: <mj+md-20070103.124124.9123.albireo@ucw.cz>
References: <1166869106.3281.587.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz> <4593890C.8030207@panasas.com> <1167300352.3281.4183.camel@laptopd505.fenrus.org> <4593E1B7.6080408@panasas.com> <E1H01Og-0007TF-00@dorka.pomaz.szeredi.hu> <20070102191504.GA5276@ucw.cz> <E1H1qRa-0001t7-00@dorka.pomaz.szeredi.hu> <20070103115632.GA3062@elf.ucw.cz> <E1H25JD-0003SN-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1H25JD-0003SN-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> High probability is all you have.  Cosmic radiation hitting your
> computer will more likly cause problems, than colliding 64bit inode
> numbers ;)

No.

If you assign 64-bit inode numbers randomly, 2^32 of them are sufficient
to generate a collision with probability around 50%.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
A Bash poem: time for echo in canyon; do echo $echo $echo; done
