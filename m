Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbWG3UGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbWG3UGc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 16:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWG3UGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 16:06:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:40677 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932459AbWG3UGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 16:06:31 -0400
From: Andi Kleen <ak@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Building external modules against objdirs
Date: Sun, 30 Jul 2006 22:06:17 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, agruen@suse.de
References: <200607301846.07797.ak@suse.de> <200607302037.02559.ak@suse.de> <20060730191700.GA30700@mars.ravnborg.org>
In-Reply-To: <20060730191700.GA30700@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607302206.17462.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 July 2006 21:17, Sam Ravnborg wrote:
> On Sun, Jul 30, 2006 at 08:37:02PM +0200, Andi Kleen wrote:
>  
> > 
> > The echo didn't output for some reason, but adding it to the error gives
> > 
> > /home/lsrc/quilt/linux/Makefile:456: *** triggered by /home/lsrc/quilt/linux/drivers/net/wireless/Kconfig /home/lsrc/quilt/linux/drivers/message/fusion/Kconfig /home/lsrc/quilt/linux/net/ieee80211/Kconfig /home/lsrc/quilt/linux/net/netfilter/Kconfig kernel configuration not valid - run 'make prepare' in /home/lsrc/quilt/linux to update it.  Stop.
> 
> What happens is that a few Kconfig files in your quilt tree are updated
> after last time you reran 'make'.

Yes that happens when I push/pop patches in quilt.

-Andi
