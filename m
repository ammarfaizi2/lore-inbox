Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263245AbTGASWK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 14:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263250AbTGASWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 14:22:10 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:7315
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263245AbTGASWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 14:22:09 -0400
Subject: Re: Procfs open hook bug.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Peter Enderborg <pme@hyglo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Theodore Ts'o" <tytso@mit.edu>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <3F016888.2080306@hyglo.com>
References: <3F016888.2080306@hyglo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057084415.18951.7.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Jul 2003 19:33:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-01 at 11:55, Peter Enderborg wrote:
> And when loading this module. The procfs gets broken. I get EINVAL for 
> open on
> /proc/meminfo and all other procfs info. Why? Should procfs inodes don't 
> have full
> filesematics? And it don't help to unload the module.

If you look at other file systems you'll see they swap the file
operations pointer

