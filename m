Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262437AbVAEOLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbVAEOLq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 09:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbVAEOLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 09:11:45 -0500
Received: from ms004msg.fastwebnet.it ([213.140.2.58]:59604 "EHLO
	ms004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S262437AbVAEOLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 09:11:44 -0500
Date: Wed, 5 Jan 2005 15:14:23 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: "Kotian, Deepak" <Deepak.Kotian@patni.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Purpose of do{}while(0) in #define spin_lock_init(x)	do {
 (x)->lock = 0; } while(0)
Message-Id: <20050105151423.68e0d404@tux.homenet>
In-Reply-To: <374639AB1012AA4C840022842AA95BC203E0E7E3@ruby.patni.com>
References: <374639AB1012AA4C840022842AA95BC203E0E7E3@ruby.patni.com>
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2005 19:31:44 +0530
"Kotian, Deepak" <Deepak.Kotian@patni.com> wrote:

> Is there any specific reason why do{}while(0) is 
> there in this definition
> #define spin_lock_init(x)	do { (x)->lock = 0; } while(0)
> 
> What could happen if it is replaced by
> #define spin_lock_init(x)	{ (x)->lock = 0; } 
> 
> There are couple of other places, where this kind of usage
> is observed in the kernel code.

look at http://www.kernelnewbies.org/faq/

-- 
	Paolo Ornati
	Gentoo Linux (kernel 2.6.10-cko2)
