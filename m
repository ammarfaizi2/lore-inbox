Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbUK2R26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbUK2R26 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 12:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbUK2R25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 12:28:57 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:47514 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261424AbUK2R2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 12:28:22 -0500
Subject: Re: MTRR vesafb and wrong X performance
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: Gerd Knorr <kraxel@bytesex.org>, pawfen@wp.pl,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041129154006.GB3898@redhat.com>
References: <1101338139.1780.9.camel@PC3.dom.pl>
	 <20041124171805.0586a5a1.akpm@osdl.org>
	 <1101419803.1764.23.camel@PC3.dom.pl> <87is7ogb93.fsf@bytesex.org>
	 <20041129154006.GB3898@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101745468.20223.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 29 Nov 2004 16:24:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-11-29 at 15:40, Dave Jones wrote:
> which is an ugly hack for the above problem imo.
> vesafb:nomtrr also fixes the problem, and leaves X free
> to set things up correctly in my experience.
> 
> If vesafb can't get it right, maybe it shouldn't be
> attempted to do it in the half-assed way it currently does.

The problem is not vesafb its X. If someone would go fix the Xorg code
to handle extending existing maps the problem will go away.

