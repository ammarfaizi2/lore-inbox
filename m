Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937801AbWLFXwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937801AbWLFXwf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 18:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937818AbWLFXwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 18:52:35 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:60652 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937801AbWLFXwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 18:52:34 -0500
Message-ID: <1165450859.45775e6b5e194@imp3-g19.free.fr>
Date: Thu, 07 Dec 2006 01:20:59 +0100
From: Remi Colinet <remi.colinet@free.fr>
To: Frank Sorenson <frank@tuxrocks.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Kernel panic at boot with recent pci quirks patch
References: <45771F0B.8090708@tuxrocks.com> <20061206232714.54ec6f7b@localhost.localdomain>
In-Reply-To: <20061206232714.54ec6f7b@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 82.216.7.132
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Sorenson <frank@tuxrocks.com> wrote:

> The latest -git tree panics at boot for me.  git-bisect traced the
offending commit to:
>
> 368c73d4f689dae0807d0a2aa74c61fd2b9b075f is first bad commit
> commit 368c73d4f689dae0807d0a2aa74c61fd2b9b075f
> Author: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Date:   Wed Oct 4 00:41:26 2006 +0100
>
>     PCI: quirks: fix the festering mess that claims to handle IDE quirks
>
> Hardware is a Dell Inspiron E1705 laptop running FC6 x86_64.
>

Could you try the following patch (already included in mm tree)?

http://www.uwsg.indiana.edu/hypermail/linux/kernel/0611.1/1568.html

Remi
