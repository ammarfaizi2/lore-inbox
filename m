Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264954AbTARSkW>; Sat, 18 Jan 2003 13:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264956AbTARSkW>; Sat, 18 Jan 2003 13:40:22 -0500
Received: from packet.digeo.com ([12.110.80.53]:43153 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264954AbTARSkV>;
	Sat, 18 Jan 2003 13:40:21 -0500
Date: Sat, 18 Jan 2003 10:50:37 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Folkert van Heusden" <folkert@vanheusden.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reading from devices in RAW mode
Message-Id: <20030118105037.70e09832.akpm@digeo.com>
In-Reply-To: <002701c2bef3$c5533450$3640a8c0@boemboem>
References: <002701c2bef3$c5533450$3640a8c0@boemboem>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Jan 2003 18:49:07.0658 (UTC) FILETIME=[47F13AA0:01C2BF22]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Folkert van Heusden" <folkert@vanheusden.com> wrote:
>
> Maybe I should've sticked to google (altough it wasn't to helpfull this
> time) but
> in this mailinglist there are a lot of knowledgeable people, so here's my
> question:
> for my data-recovery tool I like to read sectors from devices in RAW mode.

	open("/dev/fd0", O_RDONLY|O_LARGEFILE|O_DIRECT);

maybe?
