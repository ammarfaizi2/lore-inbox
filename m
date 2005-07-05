Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261952AbVGESTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbVGESTP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 14:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbVGESTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 14:19:15 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:10957 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261953AbVGESSM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 14:18:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=do2vdqqFj3vF9Pfz8lCDPP8Vo3zxZoHKkSdGxEi2PO9pL3jz9kzCy4detlUlTn2u4edXinDdu7fvt5zKikown+xWTAgnP98QGRtPKvbnEpUYIcka0RQ9Dr8Hsmgkyf5yXrrJQdFF6E0kCGQqgAfyEKdloZr2vHrgCzykB5qAkqI=
Message-ID: <4ae3c14050705111866ee0c2@mail.gmail.com>
Date: Tue, 5 Jul 2005 14:18:12 -0400
From: Xin Zhao <uszhaoxin@gmail.com>
Reply-To: Xin Zhao <uszhaoxin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6: NFS problem---cannot rmmod nfsd
In-Reply-To: <4ae3c14050705104032eee518@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4ae3c14050705104032eee518@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please discard the previous message.

I just noticed that something was wrong in the nfsd implementation
(slightly modified by me). After I fixed the problem, I can rmmod nfsd
now.

Sorry for the confusion.

-x

On 7/5/05, Xin Zhao <uszhaoxin@gmail.com> wrote:
> I compile kernel 2.6.11.10 and configure both nfs client and server as
> kernel modules.  But after I reboot the machine and did
> "/etc/init.d/nfs start", the nfsd module is inserted. But when I tried
> to rmmod this module either with "/etc/init.d/nfs stop" or "umount
> /proc/fs/nfsd; rmmod nfsd",  the nfsd reference count is always 1 and
> cannot be removed.  Why?
> 
> Thanks in advance for your kind help!
> 
> -x
>
