Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262439AbUK3XSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbUK3XSN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 18:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbUK3XKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 18:10:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:159 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262449AbUK3XGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 18:06:41 -0500
Date: Tue, 30 Nov 2004 23:05:25 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, dm-devel@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] dm: remove unused functions (fwd)
Message-ID: <20041130230525.GC24233@agk.surrey.redhat.com>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>, dm-devel@redhat.com,
	linux-kernel@vger.kernel.org
References: <20041129022940.GQ4390@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041129022940.GQ4390@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 03:29:40AM +0100, Adrian Bunk wrote:
> Please apply or comment on it.
 
Please check *why* the functions aren't used first.

e.g. An alloc function with a corresponding free that
never gets called suggests a leak to me...
 
Alasdair
-- 
agk@redhat.com
