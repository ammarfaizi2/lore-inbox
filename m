Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161140AbVKSBty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161140AbVKSBty (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 20:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161149AbVKSBty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 20:49:54 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:43501 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161140AbVKSBtx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 20:49:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e+rKIoIZI18rTwteNcEnLF6g+H/1IE5mN34/JodHtiA4hU98LoeDQqDjuLScNDkWXia/ym/aulASkWpxKOXfF621aXjm/pkuN81DBzutUXZjr8UvtPJo6xuRiNJrH0p4UZxObZEGyRP6I+Ls50l3l5oqm5I6SU9fe3ZBngt2XDg=
Message-ID: <cbec11ac0511181749p2306c514w5df57357cdc2a59d@mail.gmail.com>
Date: Sat, 19 Nov 2005 14:49:53 +1300
From: Ian McDonald <imcdnzl@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.15-rc1-mm1
Cc: Ed Tomlinson <tomlins@cam.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051119012632.GA28458@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051117111807.6d4b0535.akpm@osdl.org>
	 <200511181835.11719.tomlins@cam.org>
	 <20051118235116.GA26405@kroah.com>
	 <200511182024.33858.tomlins@cam.org>
	 <20051119012632.GA28458@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Think only the mousedev module is not loaded.  Once I modprobe it the mouse works
> > and the /dev/input/mice appears.  The mouse works normally with all buttons and wheels
> > acting normal.
>
> Then you just need to make sure that module is loaded properly, which
> doesn't sound like a udev issue :)
>
My personal experience was that all my modules loaded automatically,
including mousedev and then mousedev doesn't anymore (but haven't
checked very latest kernel tree) and then you have to manually load.

Ian
--
Ian McDonald
http://wand.net.nz/~iam4
WAND Network Research Group
University of Waikato
New Zealand
