Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262435AbVC3UEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262435AbVC3UEM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 15:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbVC3UEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 15:04:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1470 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262435AbVC3UCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 15:02:22 -0500
Date: Wed, 30 Mar 2005 15:02:18 -0500
From: Dave Jones <davej@redhat.com>
To: blaisorblade@yahoo.it
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/3] x86_64: remove dup syscall
Message-ID: <20050330200218.GA10159@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, blaisorblade@yahoo.it,
	torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20050330173219.83466EFED1@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050330173219.83466EFED1@zion>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2005 at 07:32:18PM +0200, blaisorblade@yahoo.it wrote:
 > 
 > Remove duplicated syscall entry.
 > 
 > This likely affects compilation with older GCC's (2.95.x), since in
 > arch/x86_64/kernel/syscall.c this will result in assigning twice the same
 > array element.
 > 
 > By experience, this works with newer GCC's but not with 2.95.3/4.

gcc 3.0 was the first release to support x86-64.

		Dave

