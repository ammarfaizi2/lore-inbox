Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030350AbWBHSGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030350AbWBHSGK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 13:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030408AbWBHSGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 13:06:10 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:8936 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030350AbWBHSGI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 13:06:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ulNDd46L336IiEaFx0tK6X4cZOaVvVNSAhU7HWa4Z8GWHqfcjXx1bnf9rqNVzpplWFQoPlgxaV52w65WswDPBhM6uxIbSFdUyzHBLG/G845ZS62vAy2JfC5fCqRMaXumn/ziCKm2BLUcO8PJMGwYkFui6B3tzjUPpHPebBz/vXk=
Message-ID: <661de9470602081006p2a3132e8x2436de89e9395748@mail.gmail.com>
Date: Wed, 8 Feb 2006 23:36:06 +0530
From: Balbir Singh <bsingharora@gmail.com>
To: Jan Dittmer <jdi@l4x.org>
Subject: Re: VFS: Busy inodes after unmount. Self-destruct in 5 seconds. Have a nice day...
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, dev@sw.ru,
       jblunck@suse.de
In-Reply-To: <43E9A260.6000202@l4x.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43E90573.8040305@l4x.org> <20060207162335.5304ae61.akpm@osdl.org>
	 <43E9A260.6000202@l4x.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>$ umount /mnt/data
> >>Segmentation Fault
> >>
> >>dmesg:
> >>
> >>VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...
> >>Unable to handle kernel NULL pointer dereference at virtual address 00000034
> >
> >

There were a couple of fixes suggested for the busy inodes afer
unmount problem. Please see

http://lkml.org/lkml/2006/1/25/17

and

http://lkml.org/lkml/2006/1/30/108

You could see if any one of them fixes your problem. There is also
Kirill's fix which was in mm (not sure about it now)

Balbir
