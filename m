Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262731AbVHDXpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbVHDXpG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 19:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262732AbVHDXpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 19:45:06 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:12117 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262731AbVHDXpD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 19:45:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QuziTyvJArtJZEVYxnPdltI9vA6OoTMMzB7J1u4NmGodFH54XZQH0ztKPXN669I9IKJ4go7c4YyTyzPuustBcquX6vqU9jl3UpTS0TsXwwxvzmWAwlnpIf3iLl16g3VUvxAeAhs2IWURb35PJYAQCXIxJhAIKiW6bkzLe825Gw8=
Message-ID: <311601c905080416456c92798f@mail.gmail.com>
Date: Thu, 4 Aug 2005 17:45:03 -0600
From: "Eric D. Mudama" <edmudama@gmail.com>
Reply-To: "Eric D. Mudama" <edmudama@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH] IDE disks show invalid geometries in /proc/ide/hd*/geometry
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Mark Bellon <mbellon@mvista.com>, Andre Hedrick <andre@linux-ide.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <Pine.LNX.4.61.0508040800130.22272@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42EFE547.3010206@mvista.com>
	 <Pine.LNX.4.10.10508030018390.21865-100000@master.linux-ide.org>
	 <58cb370e05080310195c244f72@mail.gmail.com>
	 <42F100C8.8040700@mvista.com>
	 <58cb370e05080311056a9276c0@mail.gmail.com>
	 <42F10DB8.4020601@mvista.com>
	 <58cb370e05080311517e6c02a8@mail.gmail.com>
	 <Pine.LNX.4.61.0508040800130.22272@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/05, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> All of these numbers are virtual, since CHS is not really used anymore, as
> we know. But, which of these fake CHS values (16383/16/63 | 65535/16/63 |
> 1023/255/63) is the right one? 255/63/4982 is another matter, since it
> [almost] matches the actual size of the disk while the other three are just
> "for the bios".

What do you mean by right?  Not one of those above values has any
physical meaning....

--eric
