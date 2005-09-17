Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbVIQPrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbVIQPrM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 11:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbVIQPrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 11:47:12 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:28454 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751125AbVIQPrL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 11:47:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t4GPlkaYcRvzvyo8vUdy7grvYxaEPZIVCE8taZMzvl5AuI623Kil0VpEtjPhDwfUm08QGLAdOOMPDFcx1EpFkadtt2o8Q714qkmGnYlhApqZGvVOytysTB0lftdUN77vBpHNxrycmtZq6EOjp3S1AS8A87elgncVzPsFCdyxLsM=
Message-ID: <12c511ca05091708476aa136cd@mail.gmail.com>
Date: Sat, 17 Sep 2005 08:47:03 -0700
From: Tony Luck <tony.luck@gmail.com>
Reply-To: tony.luck@gmail.com
To: Keith Owens <kaos@sgi.com>
Subject: Re: 2.6.14-rc1 breaks tg3 on ia64
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, "John W. Linville" <linville@tuxdriver.com>
In-Reply-To: <25288.1126596450@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050913065937.GA7849@kroah.com>
	 <25288.1126596450@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >So does reverting this patch solve the problem?
> 
> I reversing
> http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=064b53dbcc977dbf2753a67c2b8fc1c061d74f21,
> which appears to be the latest version of this patch.  There was a
> patch reject in sparc64, but the common code was reverted.  IA64 (SGI
> Altix) with that patch reverted now boots 2.6.14-rc1.

Anyone know anything more about this problem?  I'm not seeing it
on any of my systems ... so perhaps it only affects cards with a
PCI bridge on them, or cards that haven't already been initialized
by EFI.

-Tony
