Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbUBZOiq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 09:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbUBZOiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 09:38:46 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:42384 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261808AbUBZOii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 09:38:38 -0500
Date: Thu, 26 Feb 2004 14:37:10 +0000
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: rathamahata@php4.ru, linux-kernel@vger.kernel.org, gluk@php4.ru,
       anton@megashop.ru, mfedyk@matchmail.com
Subject: Re: 2.6.1 IO lockup on SMP systems
Message-ID: <20040226143710.GA3157@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, rathamahata@php4.ru,
	linux-kernel@vger.kernel.org, gluk@php4.ru, anton@megashop.ru,
	mfedyk@matchmail.com
References: <200401311940.28078.rathamahata@php4.ru> <20040223142626.48938d7c.akpm@osdl.org> <200402241454.08210.rathamahata@php4.ru> <200402261519.35506.rathamahata@php4.ru> <20040226045331.060c07d3.akpm@osdl.org> <20040226051135.17171184.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040226051135.17171184.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 05:11:35AM -0800, Andrew Morton wrote:
 > Andrew Morton <akpm@osdl.org> wrote:
 > >
 > > Not sure why the oom-killer didn't do anything.
 > 
 > There's still free swap space.  The oom-killer has problems.

That sounds odd. Surely if we have free swap, we don't
want the oom-killer to do anything ?

		Dave

