Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267034AbTBDAPQ>; Mon, 3 Feb 2003 19:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267042AbTBDAPQ>; Mon, 3 Feb 2003 19:15:16 -0500
Received: from phobos.hpl.hp.com ([192.6.19.124]:31430 "EHLO phobos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S267034AbTBDAPQ>;
	Mon, 3 Feb 2003 19:15:16 -0500
Date: Mon, 3 Feb 2003 16:09:42 -0800
To: Andi Kleen <ak@suse.de>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: 32bit emulation of wireless ioctls
Message-ID: <20030204000942.GB29628@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030128212753.GA29191@wotan.suse.de> <15927.62893.336010.363817@harpo.it.uu.se> <20030129162824.GA4773@wotan.suse.de> <15934.49235.619101.789799@harpo.it.uu.se> <20030203194923.GA27997@bougret.hpl.hp.com> <20030203201255.GA32689@wotan.suse.de> <20030203214325.GA28330@bougret.hpl.hp.com> <20030203224619.GA6405@wotan.suse.de> <20030203231740.GA29267@bougret.hpl.hp.com> <20030203235150.GA22202@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030203235150.GA22202@wotan.suse.de>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2003 at 12:51:50AM +0100, Andi Kleen wrote:
> 
> Short term I will just settle on getting that message away so that
> RedHat users won't bother me anymore. Can you suggest a good way to 
> handle SIOCGIWNAME? Should I just make it return -EINVAL?

	Just return any error, all errors will be processed the same
(and displayed to the user). Either make it convenient for you, or
make it meaningful to the user.

> -Andi

	Jean
