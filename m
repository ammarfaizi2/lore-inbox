Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161605AbWAMAOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161605AbWAMAOY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 19:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161589AbWAMAN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 19:13:58 -0500
Received: from [81.2.110.250] ([81.2.110.250]:40908 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1161598AbWAMANj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 19:13:39 -0500
Subject: Re: [GIT PATCH] PCI patches for 2.6.15 - retry
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <43C6C23A.3080402@pobox.com>
References: <20060109203711.GA25023@kroah.com>
	 <Pine.LNX.4.64.0601091557480.5588@g5.osdl.org>
	 <20060109164410.3304a0f6.akpm@osdl.org>
	 <1136857742.14532.0.camel@localhost.localdomain>
	 <43C6C23A.3080402@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 13 Jan 2006 00:16:19 +0000
Message-Id: <1137111380.29693.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-01-12 at 15:55 -0500, Jeff Garzik wrote:
> > libata I think. I reproduced it on 2.6.14-mm2 by accident with a buggy
> > pata driver.
> 
> 
> Any additional info?  How can I reproduce?

In my case I'm fairly sure (waves arms frantically) that it was
registering a controller which then failed to add any drives so it got
cleaned back up early

