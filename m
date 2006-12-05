Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967770AbWLEX3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967770AbWLEX3Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 18:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967769AbWLEX3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 18:29:24 -0500
Received: from wx-out-0506.google.com ([66.249.82.226]:55725 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967770AbWLEX3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 18:29:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Vn0KlLqvw6rJItDhLXHIMw3W46PVqacX/MTVURRlV40ewx2cJhikfRbaOCKx4gHYP8ZjS1RzzHmIVoGG4XaX0NVauP93JTQ1l/IdWlsmJfKJPDMCwk5OdR8Gybg/AhRxts50mm5CdH5zTRbj4so3wRsB6YfBAMJbk4rphOh6giE=
Message-ID: <f2b55d220612051529t3c0dcda8ma920c13b00899b10@mail.gmail.com>
Date: Tue, 5 Dec 2006 15:29:22 -0800
From: "Michael K. Edwards" <medwards.linux@gmail.com>
To: "Linux Kernel List" <linux-kernel@vger.kernel.org>,
       "Sam Ravnborg" <sam@ravnborg.org>,
       linux-arm-toolchain@lists.arm.linux.org.uk,
       linux-arm-kernel@lists.arm.linux.org.uk, crossgcc@sourceware.org
Subject: Re: More ARM binutils fuckage
In-Reply-To: <20061205193357.GF24038@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061205193357.GF24038@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/06, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> There's not much to say about this, other than scream and go hide in the
> corner.  ARM toolchains are just basically fscked.

And while we're on the topic of ARM linux toolchain fsckage, it would
be nice to know what patches and incantations are currently
recommended when configuring gcc for building various modern ARM
kernel/ABI configurations (OABI + soft VFP, EABI, etc.).

There has been some discussion on the crossgcc mailing list,
especially around recent compilers and NPTL/TLS, and crosstool has
accumulated some of the relevant patches.  If an expert (i. e.,
someone who has built their own toolchain and gotten an ARM EABI/NPTL
system all the way up) were to reply to this message with some
details, we might be able to coax chip vendors off of hard-float
gcc-3.3/glibc-2.3.x/linuxthreads toolchains.

Cheers,
- Michael
