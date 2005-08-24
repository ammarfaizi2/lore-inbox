Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbVHXTHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbVHXTHP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 15:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbVHXTHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 15:07:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12003 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751410AbVHXTHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 15:07:13 -0400
Date: Wed, 24 Aug 2005 15:06:51 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: torvalds@osdl.org, pj@sgi.com
Subject: Re: [PATCH] cpu_exclusive sched domains on partial nodes temp fix
Message-ID: <20050824190651.GA10586@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	torvalds@osdl.org, pj@sgi.com
References: <200508240401.j7O41qlB029277@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508240401.j7O41qlB029277@hera.kernel.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2005 at 09:01:52PM -0700, Linux Kernel wrote:
 > tree c81c261274011d301dfbcfd1a3e13480b93c167e
 > parent ae75784bc576a1af70509c2f3ba2b70bb65a0c58
 > author Paul Jackson <pj@sgi.com> Tue, 23 Aug 2005 15:04:27 -0700
 > committer Linus Torvalds <torvalds@g5.osdl.org> Wed, 24 Aug 2005 10:02:52 -0700
 > 
 > [PATCH] cpu_exclusive sched domains on partial nodes temp fix

This broke ppc64 for me.
 
kernel/cpuset.c: In function 'update_cpu_domains':
kernel/cpuset.c:648: error: invalid lvalue in unary '&'
kernel/cpuset.c:648: error: invalid lvalue in unary '&'

		Dave

