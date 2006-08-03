Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWHCPfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWHCPfP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 11:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWHCPfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 11:35:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11209 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964798AbWHCPfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 11:35:13 -0400
Message-ID: <44D217A7.9020608@redhat.com>
Date: Thu, 03 Aug 2006 11:35:03 -0400
From: Rik van Riel <riel@redhat.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, greg@kroah.com,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
Subject: Re: A proposal - binary
References: <44D1CC7D.4010600@vmware.com>
In-Reply-To: <44D1CC7D.4010600@vmware.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden wrote:

> And by NO circumstances, is it required to be a CLOSED source binary
> blob. In fact, why can't it be open?  In the event of a firmware bug,
> in fact, it is very desirable to have this software be open so that
> it can be fixed

You're making a very good argument as to why we should probably
require that the code linking against such an interface, if we
decide we want one, should be required to be open source.

> I think you will see why our VMI layer is quite similar to a
> traditional ROM, and very dissimilar to an evil GPL-circumvention
> device.

> (?) There are only two reasonable objections I can see to open
> sourcing the binary layer. 

Since none of the vendors that might use such a paravirtualized
ROM for Linux actually have one of these reasons for keeping their
paravirtualized ROM blob closed source, I say we might as well
require that it be open source.

As for the evilness of a binary interface - the interface between
kernel and userland is a stable binary interface and is decidedly
non-evil.  I could see a similar use for a stable paravirtualization
interface, to make compatibility between Linux and various hypervisor
versions easier.

As long as it's open source so the thing can be debugged :)

-- 
All Rights Reversed
