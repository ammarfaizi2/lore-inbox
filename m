Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbTERUhH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 16:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbTERUhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 16:37:06 -0400
Received: from holomorphy.com ([66.224.33.161]:58849 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262195AbTERUhG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 16:37:06 -0400
Date: Sun, 18 May 2003 13:49:56 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: KML <linux-kernel@vger.kernel.org>
Subject: Re: Recent changes to sysctl.h breaks glibc
Message-ID: <20030518204956.GB8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Martin Schlemmer <azarah@gentoo.org>,
	KML <linux-kernel@vger.kernel.org>
References: <1053289316.10127.41.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053289316.10127.41.camel@nosferatu.lan>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 18, 2003 at 10:21:56PM +0200, Martin Schlemmer wrote:
> Some recent changes to include/linux/sysctl.h breaks glibc.
> Problem is that __sysctl_args have been modified to use '__user',
> but that is only defined if __KERNEL__ is defined, because that
> is the only time compiler.h is included.

Don't include the kernel headers in userspace.


-- wli
