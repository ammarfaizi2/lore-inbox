Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264953AbUEQKBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264953AbUEQKBT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 06:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264944AbUEQKBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 06:01:19 -0400
Received: from adsl-74-86.38-151.net24.it ([151.38.86.74]:10509 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S264953AbUEQKBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 06:01:00 -0400
Date: Mon, 17 May 2004 12:00:58 +0200
From: Daniele Venzano <webvenza@libero.it>
To: Eric BENARD / Free <ebenard@free.fr>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.6 : bad PCI device ID for SiS ISA bridge => SiS900 eth0: Can not find ISA bridge
Message-ID: <20040517100058.GB4347@gateway.milesteg.arr>
Mail-Followup-To: Eric BENARD / Free <ebenard@free.fr>,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <200405162004.57041.ebenard@free.fr> <40A7E161.5060207@pobox.com> <200405170829.15275.ebenard@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405170829.15275.ebenard@free.fr>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.25-grsec
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2004 at 08:29:14AM +0200, Eric BENARD / Free wrote:
> This is what I mean in my email. 
> Yes sis900.c should check for both 0x08 and 0x18.
> But, I don't understand why the ID has changed (on the same hardware) between 
> 2.6.3 & 2.6.6 

sis900 didn't change in the past few kernel versions, so there must be
something else somewhere that changed the ID, as Jeff pointed out.

But since that ID is also valid, I'll make a patch for this issue also
(I'm still working on the patch for the other bug that came out in
another thread).

Bye.

-- 
-----------------------------
Daniele Venzano
Web: http://teg.homeunix.org

