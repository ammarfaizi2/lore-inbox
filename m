Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751438AbWFTRYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbWFTRYn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 13:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWFTRYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 13:24:42 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49860 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751438AbWFTRYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 13:24:42 -0400
Subject: Re: udev bluez
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Robert M. Stockmann" <stock@stokkie.net>
Cc: linux-kernel@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>,
       Hannes Reinecke <hare@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Alan Cox <alan@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0606201759140.11776-100000@hubble.stokkie.net>
References: <Pine.LNX.4.44.0606201759140.11776-100000@hubble.stokkie.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Jun 2006 18:39:22 +0100
Message-Id: <1150825163.11062.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-06-20 am 18:11 +0200, ysgrifennodd Robert M. Stockmann:
> The key piece of trouble is udev which has nowadays has to run
> in close cooperation with a daemon called hald. 

I would suggest avoiding hald is a good starting point if you want to
control the system rather than be its slave. If you want hal to do nice
things and it doesn't then file a bug with the HAL people, they are
fighting a billion random weird bits of hardware at once so all the help
they get will I'm sure be appreciated.


