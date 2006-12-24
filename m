Return-Path: <linux-kernel-owner+w=401wt.eu-S1751520AbWLXN6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbWLXN6d (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 08:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751613AbWLXN6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 08:58:33 -0500
Received: from wx-out-0506.google.com ([66.249.82.237]:11016 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbWLXN6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 08:58:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mACnqUEUrZs3J2Zps9rvtRfb9fqaPtSivnBIJU5HqGxng8PgokxsMbaZ/RM+0huHRLH2se5t/Nn7xxxF5zIIHY2/F2KgNsHUBf39vu8KaKgY7YELd4avJFJCPw2fg81ZjKiP7tMuALOw3SfN99bP631pmjSabfUz6AVVF81fkE0=
Message-ID: <5a4c581d0612240558t1a693049l2c2f311d63681b40@mail.gmail.com>
Date: Sun, 24 Dec 2006 14:58:32 +0100
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: Linux 2.6.20-rc2
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0612232043030.3671@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0612232043030.3671@woody.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/24/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
> Ok,
>  it's a couple of days delayed, because we've been trying to figure out
> what is up with the rtorrent hash failures since 2.6.18.3. I don't think
> we've made any progress, but we've cleaned up a number of suspects in the
> meantime.
>
> It's a bit sad, if only because I was really hoping to make 2.6.20 an easy
> release, and held back on merging some stuff during the merge window for
> that reason. And now we're battling something that was introduced much
> earlier..
>
> Now, practically speaking this isn't likely to affect a lot of people, but
> it's still a worrisome problem, and we've had "top people" looking at it.
> And they'll continue, but xmas is coming.
>
> In the meantime, we'll continue with the stabilization, and this mainly
> does some driver updates (usb, sound, dri, pci hotplug) and ACPI updates
> (much of the latter syntactic cleanups). And arm and powerpc updates.
>
> Shortlog appended.
>
> For developers: if you sent me a patch, and I didn't apply it, it was
> probably just missed because I concentrated on other issues. So pls
> re-send.. Unless I explicitly told you that I'm not going to pull it due
> to the merge window being over, of course ;)
>
>                 Linus

[shortlog snipped]

As already reported multiple times, including at -rc1 time...

 still need this libata-sff.c patch:

http://marc.theaimsgroup.com/?l=linux-kernel&m=116343564202844&q=raw

 to have my root device detected, ata_piix probe would otherwise
 fail as described in this thread:

http://www.ussg.iu.edu/hypermail/linux/kernel/0612.0/0690.html

Enjoy the holiday season,

--alessandro

"...when I get it, I _get_ it"

     (Lara Eidemiller)
