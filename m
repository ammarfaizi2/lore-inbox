Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129740AbQKIW6V>; Thu, 9 Nov 2000 17:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130503AbQKIW6B>; Thu, 9 Nov 2000 17:58:01 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:52231 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129740AbQKIW5z>;
	Thu, 9 Nov 2000 17:57:55 -0500
Date: Thu, 9 Nov 2000 17:57:52 -0500 (EST)
From: Infamous Woodchuck <garzik@pobox.com>
To: Ivan Passos <lists@cyclades.com>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Patch generation
In-Reply-To: <Pine.LNX.4.10.10011091442570.26422-100000@main.cyclades.com>
Message-ID: <Pine.LNX.4.10.10011091757050.24624-100000@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2000, Ivan Passos wrote:
> Where in the src tree can I find (or what is) the command to generate a
> patch file from two Linux kernel src trees, one being the original and the
> other being the newly changed one??
> 
> I've tried 'diff -ruN', but that does diff's on several files that could
> stay out of the comparison (such as the files in include/config, .files,
> etc.).

You are running the correct command for diff, you are just not running
'make mrproper' to clean your source tree before diffing.  :)

	Jeff




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
