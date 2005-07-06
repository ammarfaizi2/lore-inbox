Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVGFRWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVGFRWo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 13:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVGFRWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 13:22:44 -0400
Received: from smtp-vbr14.xs4all.nl ([194.109.24.34]:34572 "EHLO
	smtp-vbr14.xs4all.nl") by vger.kernel.org with ESMTP
	id S261162AbVGFM5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 08:57:05 -0400
Date: Wed, 6 Jul 2005 14:56:48 +0200
From: Jurriaan on adsl-gate <thunder7@xs4all.nl>
To: Rob Prowel <tempest766@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: please remove reserved word "new" from kernel headers
Message-ID: <20050706125648.GA6354@gates.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <20050706092657.95280.qmail@web60012.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050706092657.95280.qmail@web60012.mail.yahoo.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 02:26:57AM -0700, Rob Prowel wrote:
> [1.] One line summary of the problem:    
> 
> 2.4 and 2.6 kernel headers use c++ reserved word "new"
> as identifier in function prototypes.
> 
This is a FAQ.

1) kernel headers are for kernel use.
2) the kernel is written in C, not C++.
3) if userspace needs those headers, write your own based on the kernel
headers.

Do you really think you're the first to notice this since it exists in
2.4 headers?

Good luck,
Jurriaan
