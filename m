Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268203AbUHFS3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268203AbUHFS3T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 14:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268230AbUHFS3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 14:29:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60867 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268203AbUHFS3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 14:29:03 -0400
Date: Fri, 6 Aug 2004 11:28:03 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andi Kleen <ak@muc.de>
Cc: yoshfuji@linux-ipv6.org, jgarzik@pobox.com, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: block layer sg, bsg
Message-Id: <20040806112803.250679e4.davem@redhat.com>
In-Reply-To: <20040806132025.GA28248@muc.de>
References: <20040804232116.GA30152@muc.de>
	<20040804.165113.06226042.yoshfuji@linux-ipv6.org>
	<20040805114917.GC31944@muc.de>
	<20040805.204637.107575718.yoshfuji@linux-ipv6.org>
	<20040805211949.11fa33b7.davem@redhat.com>
	<20040806132025.GA28248@muc.de>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Aug 2004 15:20:25 +0200
Andi Kleen <ak@muc.de> wrote:

> People who can easily build 64bit programs normally don't 
> need any 32bit userland.

This isn't even an issue of whether some complex 64-bit
library other than libc is present.  If you have a 64-bit
userland compiler and libc, you can ship the 64-bit
version of the ipsec tools.  Heck they don't even need
something like readline or stuff like that :-)
