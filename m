Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266127AbUITHTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266127AbUITHTs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 03:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266128AbUITHTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 03:19:48 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:64440 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S266127AbUITHTr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 03:19:47 -0400
Date: Mon, 20 Sep 2004 09:17:43 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andy Lutomirski <luto@myrealbox.com>, Hans-Frieder Vogt <hfvogt@arcor.de>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.6.9-rc1-bk11+ and 2.6.9-rc1-mm3,4 r8169: freeze during boot (FIX included)
Message-ID: <20040920071743.GA7115@electric-eye.fr.zoreil.com>
References: <200409130035.50823.hfvogt@arcor.de> <20040916070211.GA32592@electric-eye.fr.zoreil.com> <200409161320.16526.jdmason@us.ltcfwd.linux.ibm.com> <200409171043.21772.jdmason@us.ltcfwd.linux.ibm.com> <20040917160151.GA29337@electric-eye.fr.zoreil.com> <414DF773.7060402@myrealbox.com> <20040919213952.GA32570@electric-eye.fr.zoreil.com> <414E46F1.9050309@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414E46F1.9050309@pobox.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> :
[...]
> That sounds like a bug right there...  need all the addresses set up 
> before we turn on stuff.

The description of the CPlusCmd in the 8169 datasheet includes a small note
which suggests that this register should be set up early.

It does not cost much to try and see if it makes a difference for DAC though.

--
Ueimor
