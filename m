Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262095AbSIYUCy>; Wed, 25 Sep 2002 16:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262098AbSIYUCy>; Wed, 25 Sep 2002 16:02:54 -0400
Received: from pizda.ninka.net ([216.101.162.242]:46798 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262095AbSIYUCx>;
	Wed, 25 Sep 2002 16:02:53 -0400
Date: Wed, 25 Sep 2002 12:57:34 -0700 (PDT)
Message-Id: <20020925.125734.32605968.davem@redhat.com>
To: zaitcev@redhat.com
Cc: benh@kernel.crashing.org, andre@linux-ide.org,
       linux-kernel@vger.kernel.org, axboe@suse.de, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] fix ide-iops for big endian archs
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020925141946.A14230@devserv.devel.redhat.com>
References: <mailman.1032957359.10217.linux-kernel2news@redhat.com>
	<20020925141946.A14230@devserv.devel.redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pete Zaitcev <zaitcev@redhat.com>
   Date: Wed, 25 Sep 2002 14:19:46 -0400
   
   IDE uses ide_insw instead of plain insw specifically to
   resolve this kind of issue, and you are trying to defeat
   the mechanism designed to help you. I smell a fish here.

They're trying to abstract out as much as possible in 2.5.x, maybe a
bit too much :-)
