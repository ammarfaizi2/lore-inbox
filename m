Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278589AbRJSSoY>; Fri, 19 Oct 2001 14:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278590AbRJSSoQ>; Fri, 19 Oct 2001 14:44:16 -0400
Received: from mail.cogenit.fr ([195.68.53.173]:57267 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S278589AbRJSSoA>;
	Fri, 19 Oct 2001 14:44:00 -0400
Date: Fri, 19 Oct 2001 20:44:24 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.12 cannot find root device on raid
Message-ID: <20011019204424.A14409@se1.cogenit.fr>
In-Reply-To: <20011018150141.A17493@alpha.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011018150141.A17493@alpha.logic.tuwien.ac.at>; from preining@logic.at on Thu, Oct 18, 2001 at 03:01:41PM +0200
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert Preining <preining@logic.at> :
[...]
> When I try to boot the new installation with the same kernel the md device
> is initialized, but the kernel cannot mount the root device. I get msgs
> about FAT problems and about mounting root as msdos.

$ less ChangeLog 
[pre1]
 - Al Viro: fix partition handling sanity check.

Can you reproduce it with >= 2.4.13-pre1 ?

We've got the same kind of lilo.conf (no md=... option) and it works
here for vanilla to 2.4.10 and -ac to 2.4.12-ac3 (no vanilla 2.4.12 tested
in a raid setup, surprise !). I would test 2.4.13-prex before modifying 
lilo.conf.

-- 
Ueimor
