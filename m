Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269781AbUJMS42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269781AbUJMS42 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 14:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269784AbUJMS42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 14:56:28 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:4784 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S269781AbUJMS41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 14:56:27 -0400
Message-ID: <416D7A0E.50503@nortelnetworks.com>
Date: Wed, 13 Oct 2004 12:55:10 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Urlichs <smurf@smurf.noris.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: single linked list header in kernel?
References: <416C1F48.4040407@nortelnetworks.com> <pan.2004.10.13.05.50.46.937470@smurf.noris.de> <416D4255.9080501@nortelnetworks.com> <pan.2004.10.13.18.25.41.367757@smurf.noris.de>
In-Reply-To: <pan.2004.10.13.18.25.41.367757@smurf.noris.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Urlichs wrote:

> I dunno, though -- open-coding a singly-linked list isn't that much of a
> problem; compared to a doubly-linked one, there's simply fewer things that
> can go horribly wrong. :-/

True.  This is likely why it hasn't yet been done.

I wonder how many places use the double-linked lists because they're there, not 
because they actually need them.  If its significant, there could be some space 
savings due to only needing one pointer rather than two.

Chris
