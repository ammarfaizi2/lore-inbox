Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267447AbUJIVSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267447AbUJIVSj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 17:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267423AbUJIVSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 17:18:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:51595 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267447AbUJIVSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 17:18:38 -0400
Date: Sat, 9 Oct 2004 14:16:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: SDiZ <gmane@sdiz.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9-rc3-mm3 kernel oops..
Message-Id: <20041009141647.14d91f34.akpm@osdl.org>
In-Reply-To: <ck935s$83k$1@sea.gmane.org>
References: <ck935s$83k$1@sea.gmane.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SDiZ <gmane@sdiz.net> wrote:
>
> I have just compiled  2.6.9-rc3-mm3 on gentoo linux,
>  When I start KDE, artsd dies and give this error:

You'll need to do

cd /usr/src/linux
wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm3/broken-out/optimize-profile-path-slightly.patch
patch -R -p1 < optimize-profile-path-slightly.patch

