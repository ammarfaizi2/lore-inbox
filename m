Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268525AbUI2TaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268525AbUI2TaA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 15:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268894AbUI2T37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 15:29:59 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:45539 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268525AbUI2T3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 15:29:46 -0400
Message-ID: <35fb2e5904092912292e2ee2be@mail.gmail.com>
Date: Wed, 29 Sep 2004 20:29:28 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Fawad Lateef <fawad_lateef@yahoo.com>
Subject: Re: facing prob related to 2.6.x kernel ............
Cc: kernelnewbies@nl.linux.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040929113813.50761.qmail@web53903.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040929113813.50761.qmail@web53903.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sep 2004 04:38:13 -0700 (PDT), Fawad Lateef
<fawad_lateef@yahoo.com> wrote:

> I m using Fedora Core 2 (2.6.8.1) on XEON 2.2GHz SMP
> Machine with 8GB RAM. When I boot my system with the
> kernel 2.6.5 or on 2.6.8.1 without SMP and HIGHMEM64G
> support it boots fine, but when I boot with SMP and
> HIGHMEM64 enabled on 2.6.8.1 or 2.6.5, the booting
> process becomes tooo slow i.e. took almost 20 or
> minutes to boot.

There was a highmem bug in recent 2.6.x kernels which apparently got
fixed - but this sounds pretty interesting behaviour (so I've copied
lkml). I could be wrong about this bug since it's just something a
vaguely recall from some changelog I happened to be reading at the
wrong end of the night.

> The Same kernel configuration on the other machine
> having same hardware configuration (except have 2GB
> RAM in other machine not 8GB) works well.
> 
> The machine creating problem is working fine with
> kernel 2.4.25 or so ............
> 
> Please do help me ..........

Could you perhaps send me your .config file and dmesg output in the
first instance. Is this all vanilla stuff or are you using some weird
and wonderful patches?

Jon.
