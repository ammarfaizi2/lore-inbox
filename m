Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbVKFKws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbVKFKws (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 05:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbVKFKws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 05:52:48 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:1571 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932345AbVKFKwr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 05:52:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HSRVwDJd2nbFZ8SieYSngupsMCUGO/SWOBSBl1wpr22MiFYsl7v9AQROmBF7hbYmtyD9yLBndzTS/Fjci1QI7AICyF5c5OblcUo/0o/wqklC1KpkYPCsOF5DvmdyPcuAkUE4waRBVrv8sHSZ4+a9GoTfW2OSjjEXcODYyaZwWjk=
Message-ID: <5a2cf1f60511060252t55e1a058o528700ea69826965@mail.gmail.com>
Date: Sun, 6 Nov 2005 11:52:47 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Edgar Hucek <hostmaster@ed-soft.at>
Subject: Re: New Linux Development Model
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <436CB162.5070100@ed-soft.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <436C7E77.3080601@ed-soft.at>
	 <20051105122958.7a2cd8c6.khali@linux-fr.org>
	 <436CB162.5070100@ed-soft.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/05, Edgar Hucek <hostmaster@ed-soft.at> wrote:
> Hi.
>
> Sorry for not posting my Name.
>
> Maybe you don't understand what i wanted to say or it's my bad english.
> The ipw2200 driver was only an example. I had also problems with, vmware,
> unionfs...
> What i mean ist, that kernel developers make incompatible changes to the
> header
> files, change structures, interfaces and so on. Which makes the kernel
> releases
> incompatible.

I will ask you just one question: as a user, why did you want to
upgrade your kernel?

On a server you want stability. So you don't upgrade. On a desktop,
there are probably a bunch of out of kernel modules that will need
upgrading with each new kernel modules. Just on the laptop I am using
right now, I will have to upgrade the vmware bridge, nvidia driver,
madwifi wireless driver, etc. And that's normal. The new development
model didn't change that.

I avoid touching my kernel on boxes I do real work with. I do build a
new kernel for test purposes and to give feedback if there's an issue.
But most of the time I skip 2-3 versions before finding a very
compelling reason to upgrade. And I stick with my distribution kernel
as much as I can.

As for kernel/drivers developers, it's another story.

If it ain't broken, don't fix it.

Jerome
