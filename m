Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932764AbWAHT5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932764AbWAHT5q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 14:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161190AbWAHT5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 14:57:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9887 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932761AbWAHT5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 14:57:42 -0500
Date: Sun, 8 Jan 2006 11:57:32 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Junio C Hamano <junkio@cox.net>
cc: Martin Langhoff <martin.langhoff@gmail.com>,
       "Brown, Len" <len.brown@intel.com>,
       "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, git@vger.kernel.org
Subject: Re: git pull on Linux/ACPI release tree
In-Reply-To: <7vace61plu.fsf@assigned-by-dhcp.cox.net>
Message-ID: <Pine.LNX.4.64.0601081156430.3169@g5.osdl.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com>
 <46a038f90601081119r39014fbi995cc8b6e95774da@mail.gmail.com>
 <7vace61plu.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 8 Jan 2006, Junio C Hamano wrote:
> 
> Careful.  I do not think rebase works across merges at all.

Right. You have to do one or the other (rebase your changes to another 
tree _or_ merge another tree into your changes), but not mix the two.

		Linus
