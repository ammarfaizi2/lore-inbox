Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbTI3OFf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 10:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbTI3OFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 10:05:35 -0400
Received: from rth.ninka.net ([216.101.162.244]:30852 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261484AbTI3OFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 10:05:32 -0400
Date: Tue, 30 Sep 2003 07:04:24 -0700
From: "David S. Miller" <davem@redhat.com>
To: Felipe W Damasio <felipewd@terra.com.br>
Cc: marcelo.tosatti@cyclades.com.br, linux-kernel@vger.kernel.org,
       chas@cmf.nrl.navy.mil
Subject: Re: [PATCH 2.4] Fix bug in atm/he.c
Message-Id: <20030930070424.5cfe479d.davem@redhat.com>
In-Reply-To: <3F7986C2.1030101@terra.com.br>
References: <3F7986C2.1030101@terra.com.br>
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Sep 2003 10:36:02 -0300
Felipe W Damasio <felipewd@terra.com.br> wrote:

> 	Patch against 2.4.23-pre5.
> 
> 	Backport of the fix the Chas applied in 2.6 kernel.

Please do not submit patches directly to head kernel maintainers for
subsystems that are very responsibly maintained.

If Chas believes he should put this ATM change into the 2.4.x
kernel, he undoubtedly will.

I don't know about other people, but when I see people send things
directly to one of the head kernel maintainers for something I
directly maintain, it drives me absolutely crazy.  This feeling is
amplified exponentially if this is submitted privately and it's a
patch that has been knowingly rejected by me, although happily that is
not the case here.

(In particular someone recenrly tried to slip the infamous arp hidden
 into 2.4.x by sending it to Marcelo privately, when Marcelo forwarded
 this to me I wanted to pull all the hair out of my head for someone
 even considering to try doing that.)
