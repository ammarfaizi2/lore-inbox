Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbQJ3QlD>; Mon, 30 Oct 2000 11:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129092AbQJ3Qkx>; Mon, 30 Oct 2000 11:40:53 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:5108 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129055AbQJ3Qks>; Mon, 30 Oct 2000 11:40:48 -0500
Date: Mon, 30 Oct 2000 14:40:16 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: kmalloc() allocation.
In-Reply-To: <Pine.LNX.3.95.1001030104956.735A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.21.0010301439080.16609-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2000, Richard B. Johnson wrote:

> How much memory would it be reasonable for kmalloc() to be able
> to allocate to a module?

> There are 256 megabytes of SDRAM available. I don't think it's
> reasonable that a 1/2 megabyte allocation would fail, especially
> since it's the first module being installed.

If you write the defragmentation code for the VM, I'll
be happy to bump up the limit a bit ...

Until then, please be modest with the amount of physically
contiguous pages you try to allocate ;)

regards,

Rik
--
"What you're running that piece of shit Gnome?!?!"
       -- Miguel de Icaza, UKUUG 2000

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
