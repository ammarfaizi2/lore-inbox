Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264088AbTF2UXN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 16:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264025AbTF2UXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 16:23:13 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:34190
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264736AbTF2UWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 16:22:46 -0400
Subject: Re: HELP! Mysterious oops around PIPE code, kernel 2.4.18
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ned Ren <nedren@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030629175836.64302.qmail@web10901.mail.yahoo.com>
References: <20030629175836.64302.qmail@web10901.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056918855.16255.17.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Jun 2003 21:34:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-06-29 at 18:58, Ned Ren wrote:
> I am running out of ideas about this problem. Our system keeps crashing near the pipe code
> (pipe_write, pipe_release etc), even within some very innocent system calls like date or grep. I
> have found a thread mentioning gcc bug and we have recompiled the kernel using both gcc-2.95 and
> gcc-3.3 (on redhat 9) but didn't help.

Do the problems occur without the ipsec/ip_ids and other odd modules
loaded ?


