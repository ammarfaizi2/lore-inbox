Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261795AbTCaTX1>; Mon, 31 Mar 2003 14:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261803AbTCaTX1>; Mon, 31 Mar 2003 14:23:27 -0500
Received: from [81.2.110.254] ([81.2.110.254]:43003 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id <S261795AbTCaTX0>;
	Mon, 31 Mar 2003 14:23:26 -0500
Subject: Re: flash as hda causes 2.4.18 to hang in
	grok_partitions()...add_to_page_cache_unique()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Wuertele <dave-gnus@bfnet.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m3smt3xuo1.fsf@bfnet.com>
References: <m3smt3xuo1.fsf@bfnet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049135769.1727.1.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 31 Mar 2003 19:36:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-31 at 19:22, David Wuertele wrote:
> I've got a mipsel linux 2.4.18 system that has a compact flash IDE
> disk as hda.  For some reason, in grok_partitions, the kernel goes
> bye-bye.  I've traced it as far as read_page_cache().

You might want to check with the linux-mips list since its a rather
obscure platform an that doesn't look much like an IDE layer change.

