Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVFMUJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVFMUJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 16:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVFMUJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 16:09:57 -0400
Received: from gorgon.vtab.com ([62.20.90.195]:11475 "EHLO gorgon.vtab.com")
	by vger.kernel.org with ESMTP id S261263AbVFMUI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 16:08:57 -0400
Date: Mon, 13 Jun 2005 22:08:55 +0200
Message-Id: <200506132008.j5DK8t010817@virtutech.se>
From: "=?ISO-8859-1?Q?Mattias Engdeg=E5rd?=" <mattias@virtutech.se>
To: cfriesen@nortel.com
Cc: jakub@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org, dwmw2@infradead.org, drepper@redhat.com
In-reply-to: <42ADE52E.1040705@nortel.com> (message from Chris Friesen on Mon,
	13 Jun 2005 13:57:34 -0600)
Subject: Re: Add pselect, ppoll system calls.
Content-Type: text/plain; charset=iso-8859-1
References: <200506131938.j5DJcKc10799@virtutech.se> <42ADE52E.1040705@nortel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Mattias Engdegård wrote:
>
>> If we can design ppoll() any way we like, which seems likely, I would
>> prefer having the timeout given as an absolute timestamp.
>
>Absolute timestamps are messy though.  How do you deal with system time 
>changes?

Monotonic clocks are there for exactly that, no?
