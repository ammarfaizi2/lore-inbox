Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbUFCGzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbUFCGzr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 02:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbUFCGzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 02:55:46 -0400
Received: from mail.gurulabs.com ([66.62.77.7]:40118 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S261358AbUFCGzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 02:55:41 -0400
Subject: Re: Dell TrueMobile 1150 PCMCIA/Orinoco/Yenta problem w/ 2.6.4/5
From: Dax Kelson <dax@gurulabs.com>
To: Aaron Mulder <ammulder@alumni.princeton.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0406022305580.6314@saturn.opentools.org>
References: <Pine.LNX.4.58.0406022305580.6314@saturn.opentools.org>
Content-Type: text/plain
Message-Id: <1086245693.3772.42.camel@mentor.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.7 (1.5.7-2) 
Date: Thu, 03 Jun 2004 00:54:53 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-02 at 23:31 -0400, Aaron Mulder wrote:
> 	I'm working with a Dell Inspiron 8200 laptop, and I've tried SuSE
> 9.1 Pro (2.6.4-54.5) and Fedora Core 2 (2.6.5-x I think, but I'm on SuSE
> now).  The laptop has 2 normal PCMCIA slots, and a Dell TrueMobile 1150
> mini-PCI card, which is apparently implemented as a PCMCIA card in a 3rd
> PCMCIA slot (handled by the orinoco_cs driver).
> 

The Fedora tracking bug is:

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=121742

It has currently about a dozen people Cc'ing it.

> 	I guess I'm assuming that this is a kernel bug and that it
> shouldn't matter if the orinoco_cs module is loaded before PCMCIA and/or
> yenta_socket.  But I guess it could be a distro bug if the module behavior
> is intentional.

It would be nice to find out which scenario it is.

Dax Kelson

