Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933145AbWGASJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933145AbWGASJt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 14:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933073AbWGASJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 14:09:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64129 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S933145AbWGASJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 14:09:47 -0400
Date: Sat, 1 Jul 2006 14:09:30 -0400
From: Dave Jones <davej@redhat.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Daniel Drake <dsd@gentoo.org>, LKML <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: Eeek! page_mapcount(page) went negative! (-1)
Message-ID: <20060701180930.GE15810@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Daniel Drake <dsd@gentoo.org>, LKML <linux-kernel@vger.kernel.org>,
	Arjan van de Ven <arjan@infradead.org>
References: <44A6AB99.8060407@gentoo.org> <44A6B11B.9080204@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A6B11B.9080204@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 02, 2006 at 03:30:03AM +1000, Nick Piggin wrote:
 > Oh. I see Arjan's pointed out it is using the nvidia driver (how
 > did he figure that out?).

intuition. The process was X, and there have been reports of
the nvidia driver triggering this in Fedora bugzilla as well
as other places.

		Dave

-- 
http://www.codemonkey.org.uk
