Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265539AbUBFUyy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 15:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265583AbUBFUyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 15:54:54 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:37136 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S265539AbUBFUyx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 15:54:53 -0500
Date: Fri, 6 Feb 2004 21:54:51 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Werner Almesberger <wa@almesberger.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VFS locking: f_pos thread-safe ?
Message-ID: <20040206215451.A2978@pclin040.win.tue.nl>
References: <20040206041223.A18820@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040206041223.A18820@almesberger.net>; from wa@almesberger.net on Fri, Feb 06, 2004 at 04:12:24AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 06, 2004 at 04:12:24AM -0300, Werner Almesberger wrote:

> I'm trying to figure out how all the locking in VFS and friends
> works, and I can't quite explain to myself how f_pos is kept
> consistent with concurrent readers.
> 
> Section 2.9.7 of the "Austin" draft of IEEE Std. 1003.1-200x,
> 28-JUL-2000, says:
> 
> "[...] read( ) [...] shall be atomic with respect to each other
>  in the effects specified in IEEE Std. 1003.1-200x when they
>  operate on regular files. If two threads each call one of these
>  functions, each call shall either see all of the specified
>  effects of the other call, or none of them."

The 2003 version can be found at

http://www.opengroup.org/onlinepubs/007904975/toc.htm
http://www.opengroup.org/onlinepubs/007904975/functions/xsh_chap02_09.html

Andries
