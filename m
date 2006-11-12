Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932910AbWKLONl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932910AbWKLONl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 09:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932912AbWKLONl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 09:13:41 -0500
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:21705 "EHLO
	mail-in-10.arcor-online.net") by vger.kernel.org with ESMTP
	id S932910AbWKLONk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 09:13:40 -0500
In-Reply-To: <455724FD.7070600@qumranet.com>
References: <200611112334.28889.bero@arklinux.org> <200611121005.58939.bero@arklinux.org> <4556E860.700@qumranet.com> <200611121436.15492.bero@arklinux.org> <455724FD.7070600@qumranet.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BCF13A1B-33C3-4949-A84C-B7624296D5FC@kernel.crashing.org>
Cc: Bernhard Rosenkraenzer <bero@arklinux.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: 2.6.19-rc5-mm1 fails to compile with gcc 4.2
Date: Sun, 12 Nov 2006 15:13:37 +0100
To: Avi Kivity <avi@qumranet.com>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 'sel' is a variable, so gcc can't provide it as an immediate  
> operand.  Specifying it as "rm" instead of "g" would have been  
> better, but can't have any real influence.

It can become an immediate operand if the function
gets inlined into a caller.


Segher

