Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263349AbTD1BhV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 21:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263140AbTD1BhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 21:37:21 -0400
Received: from user72.209.42.38.dsli.com ([209.42.38.72]:22665 "EHLO
	nolab.conman.org") by vger.kernel.org with ESMTP id S263349AbTD1BhT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 21:37:19 -0400
Date: Sun, 27 Apr 2003 21:49:35 -0400 (EDT)
From: Mark Grosberg <mark@nolab.conman.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Combined fork-exec syscall.
In-Reply-To: <3EAC86C4.5070200@redhat.com>
Message-ID: <Pine.BSO.4.44.0304272145580.23296-100000@kwalitee.nolab.conman.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 27 Apr 2003, Ulrich Drepper wrote:

> POSIX has a spawn interface, see <spawn.h> on modern systems.  A syscall
> should be compatible with this interface.

Hmmm. Okay, it isn't listed in my POSIX reference (which is really dated).

I don't have any docs on this... I did grep around some header files on a
Linux box and it looks to be a fairly complex interface. I'm not opposed
to supporting the interface, but I would like the syscall to be fairly
light-weight.

Would my original proposal cover the POSIX spec with some userland glue?

L8r,
Mark G.


