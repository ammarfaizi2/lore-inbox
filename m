Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262198AbUK3RBC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbUK3RBC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 12:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbUK3RAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 12:00:42 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:51613 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262192AbUK3Q7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 11:59:34 -0500
Subject: Re: [2.6 patch] move OSS ac97_codec.h to sound/oss/
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041130013750.GQ26051@parcelfarce.linux.theplanet.co.uk>
References: <20041130013139.GC19821@stusta.de>
	 <20041130013750.GQ26051@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101830044.25603.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 30 Nov 2004 15:54:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-11-30 at 01:37, Al Viro wrote:
> On Tue, Nov 30, 2004 at 02:31:39AM +0100, Adrian Bunk wrote:
> > As far as I can see, there's no good reason why the OSS ac97_codec.h 
> > lives in include/linux/ .
> 
> Except for a bunch of constants defined there.  Are you sure that they
> are not exposed to userland?

OSS never really exposed raw AC97 to user space. Probably it should have
for the whacky corner cases and for stuff like AC97 digitizers.

Acked-by: Alan Cox <alan@redhat.com>

