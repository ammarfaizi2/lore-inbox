Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269217AbUHZSDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269217AbUHZSDZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 14:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269175AbUHZSBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 14:01:19 -0400
Received: from h001061b078fa.ne.client2.attbi.com ([24.91.86.110]:2182 "EHLO
	linuxfarms.com") by vger.kernel.org with ESMTP id S269232AbUHZR4g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 13:56:36 -0400
Date: Thu, 26 Aug 2004 13:56:59 -0400 (EDT)
From: Arthur Perry <kernel@linuxfarms.com>
X-X-Sender: kernel@tiamat.perryconsulting.net
To: "Mauricio R. Perez - Centro de Computos" 
	<mauricio_perez@pergamino.gov.ar>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel argument list too long
In-Reply-To: <008601c48b84$d7211530$643caf0a@pergamino.gov.ar>
Message-ID: <Pine.LNX.4.58.0408261347340.11625@tiamat.perryconsulting.net>
References: <008601c48b84$d7211530$643caf0a@pergamino.gov.ar>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004, Mauricio R. Perez - Centro de Computos wrote:

> Kernel limitation of argument list it's a problem, not for things I do, else
> is for things that others do, i "need" to compile aubit4gl, but configure
> gives me Argument List Too long, and I need to have more memory for
> arguments, how can y solve this?
> kernel: 2.6.7
> gcc: 3.3.2
>
> Thanks
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


Hi Mauricio,

Here is a canned answer to that age-old question:
http://lists.gnu.org/archive/html/bug-fileutils/2001-10/msg00048.html


Now in your case, I would find some way to get configure to do what you want it to without that long argument list.
Maybe you can find some files to modify manually to "hard code" your options in the tree of aubit4gl.
Perhaps there are a few Makefile variables that can be hardcoded.
I probably would not bother recompiling the kernel in order to get a larger environment space just to pass this huge tank of a command line for a single build.


Arthur Perry
Linux Systems/Software Architect
Lead Linux Engineer

