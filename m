Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265439AbTIJSSt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 14:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265446AbTIJSSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 14:18:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24288 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265439AbTIJSSs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 14:18:48 -0400
Date: Wed, 10 Sep 2003 19:18:47 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Stephen Hemminger <shemminger@osdl.org>, jffs-dev@axis.com,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fix type mismatch in jffs.
Message-ID: <20030910181847.GO454@parcelfarce.linux.theplanet.co.uk>
References: <20030910024010.GN454@parcelfarce.linux.theplanet.co.uk> <Pine.GSO.4.21.0309101913561.1390-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0309101913561.1390-100000@vervain.sonytel.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 07:14:37PM +0200, Geert Uytterhoeven wrote:
 
> Is this endian-safe?

JFFS is host-endian.  If you want to make it swing both ways - feel free,
but AFAICS it's not worth the trouble.
