Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVFMUDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVFMUDa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 16:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVFMUDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 16:03:30 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:5552 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261300AbVFMT7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 15:59:15 -0400
Message-ID: <42ADE52E.1040705@nortel.com>
Date: Mon, 13 Jun 2005 13:57:34 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Mattias_Engdeg=E5rd?= <mattias@virtutech.se>
CC: Jakub Jelinek <jakub@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       David Woodhouse <dwmw2@infradead.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: Add pselect, ppoll system calls.
References: <200506131938.j5DJcKc10799@virtutech.se>
In-Reply-To: <200506131938.j5DJcKc10799@virtutech.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mattias Engdegård wrote:

> If we can design ppoll() any way we like, which seems likely, I would
> prefer having the timeout given as an absolute timestamp.

Absolute timestamps are messy though.  How do you deal with system time 
changes?

Chris
