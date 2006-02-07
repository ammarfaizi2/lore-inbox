Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbWBGAhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWBGAhZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 19:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWBGAhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 19:37:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10159 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964897AbWBGAhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 19:37:24 -0500
Date: Mon, 6 Feb 2006 19:37:08 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Shantanu Goel <sgoel01@yahoo.com>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [VM PATCH] rotate_reclaimable_page fails frequently
In-Reply-To: <20060206060147.13989.qmail@web33013.mail.mud.yahoo.com>
Message-ID: <Pine.LNX.4.63.0602061936250.26192@cuia.boston.redhat.com>
References: <20060206060147.13989.qmail@web33013.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Feb 2006, Shantanu Goel wrote:

> Ideally, for workloads that want to avoid paging as
> much as possible, we should perhaps have a mode where
> we never activate unmapped pages and let them all
> reside on the inactive list.  mark_page_accessed()
> would simply move an unmapped page to the head of the
> inactive list on the 2nd reference.

Clock-pro (Peter's implementation, I still need to fix mine),
should do the right thing automatically in situations like
this...

-- 
All Rights Reversed
