Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbUKEO4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbUKEO4N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 09:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262704AbUKEO4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 09:56:12 -0500
Received: from h151_115.u.wavenet.pl ([217.79.151.115]:37276 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S261645AbUKEO4C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 09:56:02 -0500
Date: Fri, 5 Nov 2004 15:55:53 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Art Haas <ahaas@airmail.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel memory requirements and BK
In-Reply-To: <20041105144621.GC7724@artsapartment.org>
Message-ID: <Pine.LNX.4.60.0411051554290.3255@alpha.polcom.net>
References: <20041105144621.GC7724@artsapartment.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Nov 2004, Art Haas wrote:

> Hi.
>
> I've been having problems with 'bk pull' execution when using kernels
> after the 2.6.8/2.6.8.1 releases. My machine has 192M of memory and 100M
> of swap, so I believe that the memory requirements for using BK to keep
> up with the kernel is sufficient, and when the machine is running with a
> 2.6.8.1 kernel I can 'bk pull' even if X windows is running. With the
> 2.6.9 and 2.6.10-rc kernels, BK bombs out with out-of-memory errors once
> the repository checking begins. I've run the 'bk pull' under the newer
> kernels without X running, as well as shutting down various daemons, and
> still things fail with memory errors.

Maybe you have some kernel debuging options set? Some of them can eat your 
RAM very fast with fs heavy load.


Grzegorz Kulewski

