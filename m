Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269754AbUJGI2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269754AbUJGI2z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 04:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269755AbUJGI2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 04:28:55 -0400
Received: from brown.brainfood.com ([146.82.138.61]:10385 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S269754AbUJGI2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 04:28:54 -0400
Date: Thu, 7 Oct 2004 03:28:51 -0500 (CDT)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
In-Reply-To: <20041007080414.GA28999@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.58.0410070328010.1194@gradall.private.brainfood.com>
References: <4164CB02.2030607@kegel.com> <20041007080414.GA28999@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2004, bert hubert wrote:

> On Wed, Oct 06, 2004 at 09:50:10PM -0700, Dan Kegel wrote:
>
> > It would be nice to know how other operating systems behave
> > when receiving UDP packets with bad checksums.  Can someone
> > try BSD and Solaris?
>
> It does not matter - this behaviour should not be depended upon. There are
> lots of other reasons why a packet might in fact not be available, kernels
> are allowed to drop UDP packets at will.

I've been lurking and reading this thread with great interest.  I had been
leaning towards thinking the kernel was wrong, until I read this email.

This is a very excellent point.
