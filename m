Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267823AbUJMO6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267823AbUJMO6Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 10:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268726AbUJMO6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 10:58:24 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:28083 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S267823AbUJMO6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 10:58:19 -0400
Message-ID: <416D4255.9080501@nortelnetworks.com>
Date: Wed, 13 Oct 2004 08:57:25 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Urlichs <smurf@smurf.noris.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: single linked list header in kernel?
References: <416C1F48.4040407@nortelnetworks.com> <pan.2004.10.13.05.50.46.937470@smurf.noris.de>
In-Reply-To: <pan.2004.10.13.05.50.46.937470@smurf.noris.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Urlichs wrote:
> Hi, Chris Friesen wrote:

>>Is there any plan to put a singly-linked list implementation into the kernel?  I 
>>mean sure its simple, but we've got the double-linked one there...

> What would you use one for? Just putting stuff in the kernel because it's
> not there yet is nonsense.

There are various places where there are open-coded single-linked list 
implementations.  This would just unify them to a single implementation.  On a 
previous occasion, someone estimated 42 instances where slist_for_each() could 
be used in net/core alone.

Chris
