Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVBFNZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVBFNZi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 08:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVBFNZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 08:25:38 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:33036 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261222AbVBFNZc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 08:25:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=X8plZ9h9yZ1hMbq/fwWH4dC2fRVf4yMs2zTUupNFkHZ60NZxUdRwjDbJ1wfVCEERjwug7ag3eKiNgjvb7DsG0dVyNyErHxYyJXMrEWm7qqUKkO2fl410prOL4euAOpKzC5/rbiBPYc9dvZykF69GUQcvFcRAuZ9PRTcBM/gBmag=
Message-ID: <58cb370e05020605256b3ea00e@mail.gmail.com>
Date: Sun, 6 Feb 2005 14:25:32 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [RFC: 2.6 patch] IDE: unsexport 3 functions
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20050205024404.GK19408@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050205024404.GK19408@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -161,8 +161,6 @@
>         return ide_stopped;
>  }
> 
> -EXPORT_SYMBOL(do_rw_taskfile);
> -

Is this patch against -mm or ide-dev-2.6?

do_rw_taskfile() is still needed for ide-disk.c in linus' tree,
the other two exports can be removed
