Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbVKUAAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbVKUAAG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 19:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbVKUAAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 19:00:05 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:19032 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932115AbVKUAAC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 19:00:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O9rEv+G/1uNoeX853xsqpsg5MziLhAlXeHEsfQ7PDdskWxh2DDnn+JTsRFFd3yz0+uzdCXxOWH+2eSij7zuBAceMJhSPOGscSqE0FtRy8P3QQN/L2HDxCkQcqDsBOvQiz/umEep9lakqha7bbvtb5CkeoZiiyhNWAyp8bmSf2LE=
Message-ID: <cbec11ac0511201600r6f819e3vf063041e068bf848@mail.gmail.com>
Date: Mon, 21 Nov 2005 13:00:02 +1300
From: Ian McDonald <imcdnzl@gmail.com>
To: Ed Tomlinson <tomlins@cam.org>
Subject: Re: 2.6.15-rc1-mm1
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200511182224.10392.tomlins@cam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051117111807.6d4b0535.akpm@osdl.org>
	 <200511182024.33858.tomlins@cam.org>
	 <20051119012632.GA28458@kroah.com>
	 <200511182224.10392.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It works with the _same_ user space in 2.6.14-rc4-mm1 and fails with 15-rc1-mm2...
> This implies either something is broken in the kernel or udev is not doing its job with
> the new (input?) changes.  Since I switched to udev this summer I have not had to load
> many modules certainly not mousedev.
>
> I'll do a bit of experimenting this weekend to see if I cannot figure out more about what is
> happening.
>
> Thanks for the help
> Ed
>
I would suggest using git-bisect to find the problem - I do know that
the problem was/is in Linus Torvalds tree. It was fine around 2.6.13
timeframe and broke sometime after this. I find git-bisect very
powerful for testing these types of bugs.

I was going to test myself in this way but the machine which
experienced the problem caught fire!! I know this sounds like the dog
ate my homework but unfortunately it was true and it was a machine I
borrowed too....

Ian
--
Ian McDonald
http://wand.net.nz/~iam4
WAND Network Research Group
University of Waikato
New Zealand
