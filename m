Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265257AbUGGR6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265257AbUGGR6d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 13:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265261AbUGGR6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 13:58:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60644 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265257AbUGGR6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 13:58:19 -0400
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Ray Lee <ray-lk@madrabbit.org>, tomstdenis@yahoo.com, eger@havoc.gtf.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 0xdeadbeef vs 0xdeadbeefL
References: <1089165901.4373.175.camel@orca.madrabbit.org>
	<orn02cqs3u.fsf@livre.redhat.lsd.ic.unicamp.br>
	<20040707064857.GF12308@parcelfarce.linux.theplanet.co.uk>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 07 Jul 2004 14:58:08 -0300
In-Reply-To: <20040707064857.GF12308@parcelfarce.linux.theplanet.co.uk>
Message-ID: <orbrirg0nj.fsf@free.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul  7, 2004, viro@parcelfarce.linux.theplanet.co.uk wrote:

> On Wed, Jul 07, 2004 at 02:55:01AM -0300, Alexandre Oliva wrote:
>> On Jul  6, 2004, Ray Lee <ray-lk@madrabbit.org> wrote:
>> 
>> > Which means 0xdeadbeef is a perfectly valid literal for an unsigned int.
>> 
>> Assuming ints are 32-bits wide.

> ITYM "at least 32-bits wide".

No, exactly 32-bits wide.  If they're wider, it's going to be signed
int.  If they're narrower, it's going to be long or unsigned long,
depending on how wide long is.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
