Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265484AbRGBXeO>; Mon, 2 Jul 2001 19:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265494AbRGBXeF>; Mon, 2 Jul 2001 19:34:05 -0400
Received: from ns.suse.de ([213.95.15.193]:32009 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S265484AbRGBXdy>;
	Mon, 2 Jul 2001 19:33:54 -0400
To: Timur Tabi <ttabi@interactivesi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pte_val(*pte) as lvalue
In-Reply-To: <9LUWoC.A.W3G.sIQQ7@dinero.interactivesi.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 03 Jul 2001 01:33:42 +0200
In-Reply-To: Timur Tabi's message of "3 Jul 2001 01:29:40 +0200"
Message-ID: <oupelryykh5.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi <ttabi@interactivesi.com> writes:

> 
> What is the accepted way to assign an integer to a pte that works in 2.2 and
> 2.4?

set_pte(pte, mk_pte( ... )) 


-Andi

