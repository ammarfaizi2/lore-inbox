Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266797AbSLJVnj>; Tue, 10 Dec 2002 16:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266805AbSLJVnj>; Tue, 10 Dec 2002 16:43:39 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:34735 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S266797AbSLJVnj>; Tue, 10 Dec 2002 16:43:39 -0500
Date: Tue, 10 Dec 2002 16:52:53 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: "David S. Miller" <davem@redhat.com>
Cc: raul@pleyades.net, "" <linux-kernel@vger.kernel.org>
Subject: Re: [BK-2.4] [PATCH] Small do_mmap_pgoff correction
In-Reply-To: <20021210.132207.23687680.davem@redhat.com>
Message-ID: <Pine.LNX.4.50L.0212101652480.5093-100000@freak.distro.conectiva>
References: <20021210204530.GA63@DervishD> <20021210.124740.86261163.davem@redhat.com>
 <20021210205906.GA82@DervishD> <20021210.132207.23687680.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Dec 2002, David S. Miller wrote:

>    From: DervishD <raul@pleyades.net>
>    Date: Tue, 10 Dec 2002 21:59:06 +0100
>
>        Because PAGE_ALIGN won't return 0?
>
> What if TASK_SIZE is ~0?  Both your checks will pass
> for the case of (SIZE_MAX-PAGE_SIZE + 1) to ~0 cases.

Reverted.
