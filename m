Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbUC0OaO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 09:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbUC0OaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 09:30:14 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:37127 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261753AbUC0OaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 09:30:07 -0500
Date: Sat, 27 Mar 2004 15:18:28 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Michel Roelofs <huender.k@solcon.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4: Oops when mounting HFS on ppc32
In-Reply-To: <1080156832.2867.4.camel@maan>
Message-ID: <Pine.LNX.4.58.0403271506080.23212@serv>
References: <1080156832.2867.4.camel@maan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 24 Mar 2004, Michel Roelofs wrote:

> Kernel: plain 2.6.4 from ftp.nl.kernel.org
>
> When mounting an hfs filesystem on my ppc32 (powertower pro 250, 604e
> cpu) I got the following:
>
> kernel BUG in grow_buffers at fs/buffer.c:1191!

The problem is that this happens only on Macs, it doesn't seem to be a big
endian problem, as I've just tested it on a different ppc32 machine and it
works fine. So I need someone who at least tries to figure out what
happens, before I can fix this rather mysterious bug. All I know is that
something gets corrupted, but I have no idea what.

bye, Roman
