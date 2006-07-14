Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161249AbWGNEUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161249AbWGNEUw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 00:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161253AbWGNEUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 00:20:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43957 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161249AbWGNEUw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 00:20:52 -0400
Date: Fri, 14 Jul 2006 00:20:40 -0400
From: Dave Jones <davej@redhat.com>
To: Willy Tarreau <w@1wt.eu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: memory corruptor in .18rc1-git
Message-ID: <20060714042039.GB22802@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Willy Tarreau <w@1wt.eu>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	torvalds@osdl.org
References: <20060713221330.GB3371@redhat.com> <20060713152425.86412ea3.akpm@osdl.org> <20060713223029.GD3371@redhat.com> <20060714041254.GG2037@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060714041254.GG2037@1wt.eu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2006 at 06:12:54AM +0200, Willy Tarreau wrote:
 
 > > I can give it a shot, but as it takes a while for this to manifest, I may
 > > not be able to say for certain whether it fixes it or not.
 > 
 > Then you might consider slightly changing the debug messages, because they
 > are identical in list_add and list_del. Having a way to differenciate
 > between the two functions might give one more indication.

BUG() gives a line number.

		Dave

-- 
http://www.codemonkey.org.uk
