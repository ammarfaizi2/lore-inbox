Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTESKjI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 06:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbTESKjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 06:39:08 -0400
Received: from holomorphy.com ([66.224.33.161]:13541 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262373AbTESKjG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 06:39:06 -0400
Date: Mon, 19 May 2003 03:51:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: Christoph Hellwig <hch@infradead.org>, KML <linux-kernel@vger.kernel.org>
Subject: Re: Recent changes to sysctl.h breaks glibc
Message-ID: <20030519105152.GD8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Martin Schlemmer <azarah@gentoo.org>,
	Christoph Hellwig <hch@infradead.org>,
	KML <linux-kernel@vger.kernel.org>
References: <1053289316.10127.41.camel@nosferatu.lan> <20030518204956.GB8978@holomorphy.com> <1053292339.10127.45.camel@nosferatu.lan> <20030519063813.A30004@infradead.org> <1053341023.9152.64.camel@workshop.saharact.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053341023.9152.64.camel@workshop.saharact.lan>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 12:43:44PM +0200, Martin Schlemmer wrote:
> Right, so who are going to tell the glibc guys that ?
> -----------------------------------------------------------------
> configure: error: GNU libc requires kernel header files from
> Linux 2.0.10 or later to be installed before configuring.
> The kernel header files are found usually in /usr/include/asm and
> /usr/include/linux; make sure these directories use files from
> Linux 2.0.10 or later.  This check uses <linux/version.h>, so
> make sure that file was built correctly when installing the kernel
> header
> files.  To use kernel headers not from /usr/include/linux, use the
> configure option --with-headers.
> -----------------------------------------------------------------

IIRC you're supposed to use some sort of sanitized copy, not the things
directly. IMHO the current state of affairs sucks as there is no
standard set of ABI headers, but grabbing them right out of the kernel
is definitely not the way to go.


-- wli
