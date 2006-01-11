Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751720AbWAKSpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbWAKSpK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 13:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbWAKSpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 13:45:09 -0500
Received: from kanga.kvack.org ([66.96.29.28]:60384 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751720AbWAKSpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 13:45:08 -0500
Date: Wed, 11 Jan 2006 13:41:12 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Kenny Simpson <theonetruekenny@yahoo.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is user-space AIO dead?
Message-ID: <20060111184112.GA21922@kvack.org>
References: <20060111181252.61498.qmail@web34103.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111181252.61498.qmail@web34103.mail.mud.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 10:12:52AM -0800, Kenny Simpson wrote:
> If I want a transactional engine (like a database) that needs to persist to stable storage, is it
> still best to use a helper thread to do write/fsync or O_SYNC|O_DIRECT?

It all depends on which database engine you're using.  Getting Oracle 
tuned to the Linux AIO implementation took a few revisions, but what's 
out in the fields these days makes good use of aio to gain 10-15% on 
the usual large industry standard database benchmark.

		-ben
-- 
"You know, I've seen some crystals do some pretty trippy shit, man."
Don't Email: <dont@kvack.org>.
