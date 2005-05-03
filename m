Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVECMxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVECMxy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 08:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVECMxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 08:53:54 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:65092 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261509AbVECMxw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 08:53:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QdMTOqU3J1mly4NVmAuZ/CJe9xhUVBr/5qn5OoDTZqp+3ScViTIIHHAe2h/v/DHegPVZv6TJjiWhP+SzHzHThtnSUSjn8jc5faEtD4JrVv3Z6BvtR/Bh9b7hSwvRgyeuSVD5s/jpgRnkpn16UJNK/MJUYQu1KUPSFgicZuuMsQs=
Message-ID: <add7e60b050503055326cac846@mail.gmail.com>
Date: Tue, 3 May 2005 20:53:52 +0800
From: Christopher Chan <feizhou.asia@gmail.com>
Reply-To: Christopher Chan <feizhou.asia@gmail.com>
To: Davy Durham <pubaddr2@davyandbeth.com>
Subject: Re: ext3 issue..
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <427770C9.1050808@davyandbeth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4270FA5B.5060609@davyandbeth.com>
	 <427770C9.1050808@davyandbeth.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Davy.

On 5/3/05, Davy Durham <pubaddr2@davyandbeth.com> wrote:
> I was thinking about delving into this problem a bit.   I don't have any
> unpartitioned free space on my physical drive.  I was going to ask if
> it's possible to create a virtual device in RAM or in a file that I
> could then create an ext3 file system on for testing.. I'm at least
> trying to recreate the situation of the negative diskspace usage.. then
> maybe try to debug ext3 a bit.  At first I thought "oh RAMFS!", then "no
> wait, I couldn't create an EXT3 file system that way".. I need a
> non-physical (block? or character?) device.

It is called a ram disk. You might want to pass options to the kernel
to increase the size of the ramdisk.

Look under Documentation for ramdisk.txt in the linux source tree.
