Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315946AbSGLKxl>; Fri, 12 Jul 2002 06:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316070AbSGLKxk>; Fri, 12 Jul 2002 06:53:40 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:49473 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S315946AbSGLKxj>;
	Fri, 12 Jul 2002 06:53:39 -0400
Date: Fri, 12 Jul 2002 11:57:37 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein.homenet>
To: louie miranda <louie@chikka.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: no msg when linux-kernel boot.
In-Reply-To: <035401c22969$3c39a1b0$6b48becb@noc2>
Message-ID: <Pine.LNX.4.33.0207121156570.1088-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

check /proc/cmdline to see if there is a "quiet" option listed there. If
so, edit /etc/lilo.conf and get rid of it from "append=" line and rerun
lilo and reboot.

Regards
Tigran

On Fri, 12 Jul 2002, louie miranda wrote:

> Hi,
>
> I saw this server twice. When she boots, it does not show extra kernel
> "echo, requests" (Initializations)
>
> ex:
>
>
> LILO: linux...
> Booting the kernel
>
> and after that it pauses for a little while
>
> and just shows the login prompt
>
>
> Linux
>
> Login:
>
>
> ---
>
> Any ideas on this is much appreciated..
>
>
>
>
>
> Thanks,
> Louie...
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

