Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263538AbTJVLew (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 07:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTJVLev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 07:34:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17674 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263538AbTJVLeu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 07:34:50 -0400
Date: Wed, 22 Oct 2003 12:34:20 +0100
From: Dave Jones <davej@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: scx200_wdt: Include linux/fs.h for struct file
Message-ID: <20031022113419.GA18118@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20031022112035.GA25439@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031022112035.GA25439@gondor.apana.org.au>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 22, 2003 at 09:20:35PM +1000, Herbert Xu wrote:
 
 > This patch adds an explicit inclusion of linux/fs.h as it needs to
 > dereference struct file *.  This is needed for it to compile on
 > non-i386 architectures.

A better question is why we're allowing Geode drivers to be compiled
on non-i386.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
