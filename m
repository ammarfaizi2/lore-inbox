Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267413AbSKQABJ>; Sat, 16 Nov 2002 19:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267415AbSKQABI>; Sat, 16 Nov 2002 19:01:08 -0500
Received: from tapu.f00f.org ([66.60.186.129]:24774 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S267413AbSKQABH>;
	Sat, 16 Nov 2002 19:01:07 -0500
Date: Sat, 16 Nov 2002 16:08:06 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [PATCH] 2.5.47: strdup()
Message-ID: <20021117000806.GB443@tapu.f00f.org>
References: <87d6p63ui2.fsf@goat.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d6p63ui2.fsf@goat.bogus.local>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2002 at 07:21:09AM +0100, Olaf Dietsche wrote:

> This *untested* patch adds strdup(). There are about five or six
> different strdup() implementations in various parts of the kernel.

How many users of these functions are there?  I really don't like
certain functions which allocate memory in nebulous ways and almost
would prefer all users of this are fixed to specifically allocate and
str[n]cpy copy themselves making it clear who is allocating memory and
also who should free it.



