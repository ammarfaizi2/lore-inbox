Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751706AbWBELEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbWBELEn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 06:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbWBELEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 06:04:43 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:46817 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1751449AbWBELEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 06:04:43 -0500
Date: Sun, 5 Feb 2006 12:04:43 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Pawe? Zadr?g <p.zeddi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to tune kernel to swap more often (video ram swap)
Message-ID: <20060205110443.GA5693@stiffy.osknowledge.org>
References: <b92f4fd10602050204g41f70f70p@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b92f4fd10602050204g41f70f70p@mail.gmail.com>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc2-marc-g5b7b644c
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pawe? Zadr?g <p.zeddi@gmail.com> [2006-02-05 11:04:25 +0100]:

> Yo...
> 
> In normal case, using harddisk as a swap space i should ask how to cut
> down swapping, or make swapping when idle, etc... My case is a little
> bit diffrent... I have a 256MB video card, while 240MB of it is used
> as a swap space. And the question is: how to tune kernel to swap more
> often. I known swapped memory must be copied back to ram before beeing
> used, so i'm looking for a reasonable tunning values...
> 
> What do You think about that mighty list ?

Try playing around with /proc/sys/vm/swappiness. If you google for
'/proc/sys/vm/swappiness' you may find solutions on swapping.

Marc

