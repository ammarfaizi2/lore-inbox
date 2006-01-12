Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161240AbWALUTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161240AbWALUTb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 15:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161244AbWALUTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 15:19:31 -0500
Received: from a.relay.invitel.net ([62.77.203.3]:48272 "EHLO
	a.relay.invitel.net") by vger.kernel.org with ESMTP
	id S1161240AbWALUTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 15:19:30 -0500
Date: Thu, 12 Jan 2006 21:19:24 +0100
From: =?iso-8859-1?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: Hugh Dickins <hugh@veritas.com>
Cc: Kurt Wall <kwall@kurtwerks.com>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: OT: fork(): parent or child should run first?
Message-ID: <20060112201924.GA4026@lgb.hu>
Reply-To: lgb@lgb.hu
References: <20060111123745.GB30219@lgb.hu> <1136983910.2929.39.camel@laptopd505.fenrus.org> <20060111130255.GC30219@lgb.hu> <20060112013858.GB6178@kurtwerks.com> <Pine.LNX.4.61.0601121719550.9759@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0601121719550.9759@goblin.wat.veritas.com>
X-Operating-System: vega Linux 2.6.12-10-686 i686
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 05:23:48PM +0000, Hugh Dickins wrote:
> I've not been following the thread, but if your suggestion is good, then
> better would be to use mmap MAP_SHARED|MAP_ANONYMOUS - that gives memory
> shared between parent and children, without all the nuisance of shmids.

Well you would be right, but children processes do exec() for application(s)
does not know anything about my ideas :) That's why I wanted to take care
about them in parent and do 'cleanup' there.

-- 
- Gábor
