Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264373AbUE2UxC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbUE2UxC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 16:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbUE2UxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 16:53:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59353 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264373AbUE2UxA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 16:53:00 -0400
Date: Sat, 29 May 2004 21:52:59 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Netdev <netdev@oss.sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@redhat.com>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [PATCH] remove net driver ugliness that sparse complains about
Message-ID: <20040529205259.GJ12308@parcelfarce.linux.theplanet.co.uk>
References: <40B8D2F8.6090905@pobox.com> <Pine.LNX.4.58.0405291117511.1648@ppc970.osdl.org> <20040529204230.GG12308@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040529204230.GG12308@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2004 at 09:42:30PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> The rest of patchset (~360Kb right now, and it will grow more) does include
> several splittings of structs, BTW.  It removes pretty much all noise on
> my alpha / amd64 / x86 builds; the rest is real issues.

BTW, could you hold on with fs/compat_ioctl.c patches?  I've got a pile
in that area and it would be really painful to untangle in case of
conflicts ;-/
