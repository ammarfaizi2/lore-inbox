Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264802AbTIJVD2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 17:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265731AbTIJVD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 17:03:28 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:51668 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S264802AbTIJVDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 17:03:24 -0400
Date: Wed, 10 Sep 2003 17:00:08 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: kbuild: Build minimum in scripts/ when changing configuration
In-Reply-To: <20030910201320.GA5852@mars.ravnborg.org>
Message-ID: <Pine.GSO.4.33.0309101658570.13584-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Sep 2003, Sam Ravnborg wrote:
>I am aware of that.
>It does not happen in the usual situations where it would have become
>visible.
>One example is "make oldconfig" where it appears, but there is so much
>other output that I avoided to introduce special support to avoid it.
>
>You see the same with asm-offset.h. We could avoid that with a hack
>in Makefile.build, but I have resisted to do it, again to avoid special cases.

Actually, adding "@:" to the generic rules would work... and fix this
little spew "everywhere".

--Ricky


