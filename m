Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbTLNQzI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 11:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbTLNQzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 11:55:08 -0500
Received: from pix-525-pool.redhat.com ([66.187.233.200]:1235 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262118AbTLNQzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 11:55:06 -0500
Date: Sun, 14 Dec 2003 17:54:36 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [CFT][RFC] HT scheduler
Message-ID: <20031214165435.GA10326@devserv.devel.redhat.com>
References: <20031213022038.300B22C2C1@lists.samba.org.suse.lists.linux.kernel> <3FDAB517.4000309@cyberone.com.au.suse.lists.linux.kernel> <brgeo7$huv$1@gatekeeper.tmr.com.suse.lists.linux.kernel> <3FDBC876.3020603@cyberone.com.au.suse.lists.linux.kernel> <20031214043245.GC21241@mail.shareable.org.suse.lists.linux.kernel> <3FDC3023.9030708@cyberone.com.au.suse.lists.linux.kernel> <1071398761.5233.1.camel@laptop.fenrus.com.suse.lists.linux.kernel> <p73ad5vs6vk.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73ad5vs6vk.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 14, 2003 at 05:26:23PM +0100, Andi Kleen wrote:
> Arjan van de Ven <arjanv@redhat.com> writes:
> > 
> > also keep in mind that current x86 processors all will internally
> > optimize out the lock prefix in UP mode or when the cacheline is owned
> > exclusive.... If HT matters here let the cpu optimize it out.....
> 
> Are you sure they optimize it out in UP mode? IMHO this would break
> device drivers that use locked cycles to communicate with bus master
> devices (and which are not necessarily mapped uncachable/write combining) 

uncachable regions are different obviously....
