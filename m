Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbUJXUW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbUJXUW0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 16:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbUJXUWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 16:22:25 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:9840 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261652AbUJXUWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 16:22:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=SgUJKST00YthL2VKUF3+N6yTwt4zBIJXfJfH9nbNRhxV1t2RTND13U4yFgqplTZT9HyggJpY8odbyF5WRqr3YcTTjdtauyys8KLxF39XX+Krrt3ZshZD0nnrh91C/x4adnJyFTC2oEy2S3hMrMJzJTXSjK6O+n523KwmYuBNmH8=
Message-ID: <58cb370e04102413156543b72e@mail.gmail.com>
Date: Sun, 24 Oct 2004 22:15:26 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: James Cloos <cloos@jhcloos.com>
Subject: Re: [BK PATCHES] ide-2.6 update
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <m3zn2boq1h.fsf@lugabout.cloos.reno.nv.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <58cb370e04102405081d62bf40@mail.gmail.com>
	 <m3zn2boq1h.fsf@lugabout.cloos.reno.nv.us>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Oct 2004 12:48:58 -0700, James Cloos <cloos@jhcloos.com> wrote:
> Are all of the data displayed in /proc/ide/piix et al now available
> in sysfs?  If so, 'twould've been useful for a small utility -- a

All these data can be obtained from user-space,
no need for bloating sysfs.

> la lsscsi(8) -- that can format that data like the /proc/ide files
> to have been released before dropping the /proc files....
> It is a regression to loose convenient access to the controllers'
> current configs....

http://home.elka.pw.edu.pl/~bzolnier/atapci/

released > 2 years ago :)

works fine but probably needs some cut'n'paste updates

Most of these /proc files were buggy / inaccurate and keeping them
had real maintenance cost (hpt366 bug, triflex bug etc.) with absolutely no
added gain in debugging problems (raw PCI config gives much more info).

and yes, this should've been done 2 years ago...
