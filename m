Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030549AbWCTWKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030549AbWCTWKQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030590AbWCTWKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:10:15 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:55773 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030587AbWCTWKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:10:07 -0500
Date: Mon, 20 Mar 2006 23:09:47 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, klibc@zytor.com,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: Merge strategy for klibc
In-Reply-To: <441F0859.2010703@zytor.com>
Message-ID: <Pine.LNX.4.64.0603202228441.17704@scrub.home>
References: <441F0859.2010703@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 20 Mar 2006, H. Peter Anvin wrote:

You forgot to provide any information (at least a summary) about what this 
is and how this will work. Please don't assume everyone is familiar with 
it.

There is one major question: how will this interface to distributions?

How can distributions add their own initializations and configurations or 
are they going to put an initrd on top of the kernel initrd? If this will 
have a kernel and a distribution part, it poses the question whether klibc 
has to be distributed with the kernel at all (a libc has a standard API 
after all) and the kernel just provides the kernel specific parts to 
whatever the distribution provides.

bye, Roman
