Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269036AbTHJOAQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 10:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269144AbTHJOAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 10:00:15 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:14794 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S269036AbTHJOAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 10:00:11 -0400
Date: Sun, 10 Aug 2003 14:59:40 +0100
From: Dave Jones <davej@redhat.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.0-test3] i386 cpuid.c devfs support 2/2
Message-ID: <20030810135939.GB17154@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrey Borzenkov <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org
References: <200308101252.26584.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308101252.26584.arvidjaar@mail.ru>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 10, 2003 at 12:52:26PM +0400, Andrey Borzenkov wrote:
 > the same question about default permissions as for msr.c; the same problem 
 > with module unload.

cpuid is less harmful than msr, but it's possible some admins may not
want their users being able to read things like CPU serial numbers
(if enabled).

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
