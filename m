Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265489AbUGMQic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265489AbUGMQic (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 12:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265487AbUGMQic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 12:38:32 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:23347 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S265482AbUGMQia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 12:38:30 -0400
Date: Tue, 13 Jul 2004 18:15:04 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@localhost.localdomain
To: Ricky Beam <jfbeam@bluetronic.net>
cc: "Eric D. Mudama" <edmudama@bounceswoosh.org>,
       "Robert M. Stockmann" <stock@stokkie.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: SATA disk device naming ?
In-Reply-To: <Pine.GSO.4.33.0407131221000.25702-100000@sweetums.bluetronic.net>
Message-ID: <Pine.LNX.4.44.0407131812340.30340-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jul 2004, Ricky Beam wrote:

> On Tue, 13 Jul 2004, Eric D. Mudama wrote:
> >... "root=LABEL=/" ...
> 
> I've seen the LABEL method not work at all. (2.6.7-rc3 on the wikipedia
> servers.)

right, the LABEL=/ never works for me so I always replace it with explicit 
"root=/dev/sda2" thing, but this is problematic if "/dev/sda2" becomes 
"/dev/hda2" if you boot with IDE driver compiled in, as opposed to SATA 
driver.

I assumed that "LABEL=/" thing is a RedHat-specific kernel's feature but 
never bothered to check. The reason I assumed so was that the problems 
always happen after installation, i.e. as soon as I replace the vendor's 
generic kernel with the one properly optimized for my specific needs.

Kind regards
Tigran

