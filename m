Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbVCRQhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVCRQhl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 11:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbVCRQe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 11:34:28 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:8429 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261672AbVCRQeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 11:34:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=iPqr72BQssX2tCB6PAxfTNn59sq3zxnYMiJ9hXw0onneUkVwbEfx7/n/QFIi0CI5QRypoXqVntFR7UzR2rwE8WGjfUietDfC3oE3wut40AGKyTgytUaoW1wCIjE4d+kS7rD3nKeMz5b3h0xo+5B6I8vSGtz4mxxVjQAuQcD2egc=
Message-ID: <58cb370e05031808341bbe5622@mail.gmail.com>
Date: Fri, 18 Mar 2005 17:34:06 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Paul <set@pobox.com>, Linux kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Repeatable IDE Oops for 2.6.11 (ide-scsi vs ide-cdrom)
In-Reply-To: <20050314065508.GA7974@squish.home.loc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050314065508.GA7974@squish.home.loc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005 01:55:08 -0500, Paul <set@pobox.com> wrote:
>         Hi;
> 
>         Here is what I did:
> 
> # modprobe ide-scsi
> # cd /proc/ide/hdd      (this is a dvdrw drive)
> # cat driver
> > ide-cdrom version 4.61
> # echo ide-scsi > driver
> # cat driver
> > ide-scsi (something--- didnt note exactly, except it was ide-scsi)
> # echo ide-cdrom > driver
> 
> The shell is killed and Oops.
> 
> Machine flakey and half alive at this point. Reboot with Alt-sysrq.
> The same thing works with 2.6.10, without Oops.

Please see http://lkml.org/lkml/2005/2/11/132
