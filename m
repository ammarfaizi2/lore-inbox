Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750963AbWFEVbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbWFEVbO (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 17:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbWFEVbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 17:31:13 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:54800 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750963AbWFEVbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 17:31:13 -0400
Date: Mon, 5 Jun 2006 23:31:11 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: kbuild patch (20a468b51325b3636785a8ca0047ae514b39cbd5) breaks parallels-config
Message-ID: <20060605213111.GA15346@mars.ravnborg.org>
References: <20060605164950.GB4552@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060605164950.GB4552@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2006 at 06:49:50PM +0200, Thomas Glanzmann wrote:
> Hello Sam,
> To reproduce:
> 
>         * Go to http://www.parallels.com/en/download/ and download the packages for your distribution
> 
>         cd /usr/lib/parallels
>         ./configure
>         make
x86 not supported - and I do not want to dig up my sparc...

> 
> The broken parallels makefiles are in:
> 
>         /usr/lib/parallels/drivers/drv_net/linux/Makefile
>         /usr/lib/parallels/drivers/drv_net/Makefile
>         /usr/lib/parallels/drivers/drv_virtualnic/Makefile
>         /usr/lib/parallels/drivers/drv_main/Makefile
>         /usr/lib/parallels/drivers/hypervisor/Makefile        <<<<< This is the first one which breaks. The other follow.
>         /usr/lib/parallels/drivers/Makefile
Can you please provide a copy of:
-> The offending Makfile
-> The exact command executed to build the module

	Sam
