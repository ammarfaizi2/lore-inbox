Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbULMVTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbULMVTM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 16:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbULMVTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 16:19:11 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:32208 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261341AbULMVTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 16:19:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=VpTzutDJT/RQN13M2/9sPFCPMzB/iWf47UDWV9CZ5sIQezySXivttN5YMbaQEKMuJdoXmC1AfwmTYDrPxKABxL9W6Clik5nPuzQ6U11snW+AfPKgt0NSgU+xThKmOLJSGOIiXOTNhA3u6YAdOQb/mVx7i5f31KajAMggkjSAp58=
Message-ID: <58cb370e041213131941f26707@mail.gmail.com>
Date: Mon, 13 Dec 2004 22:19:07 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: Why is "SAMSUNG CD-ROM SC-148F" blacklisted?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <cp78ct$d65$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <cp78ct$d65$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Dec 2004 20:58:36 +0500, Alexander E. Patrakov
<patrakov@ums.usu.ru> wrote:
> The "SAMSUNG CD-ROM SC-148F" drive is listed in drive_blacklist in
> ide-dma.c. However, this drive worked well with DMA enabled with earlier
> kernel versions (<=2.6.8.1) where the "via82cxxx" driver did not look at
> this blacklist. So the question: what was the reason for blacklisting this
> (apparently working) drive? Is it still valid?
> 
> Details on my CD-ROM drive are pasted below.

drive is removed from the blacklist, thanks for the report
