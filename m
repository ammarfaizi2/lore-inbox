Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264268AbUEXMGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264268AbUEXMGs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 08:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264263AbUEXMGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 08:06:47 -0400
Received: from canuck.infradead.org ([205.233.217.7]:40199 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S264268AbUEXMFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 08:05:23 -0400
Date: Mon, 24 May 2004 08:05:21 -0400
From: hch@infradead.org
To: "Peter J. Braam" <braam@clusterfs.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       "'Phil Schwan'" <phil@clusterfs.com>
Subject: Re: [PATCH/RFC] Lustre VFS patch
Message-ID: <20040524120521.GD26863@infradead.org>
Mail-Followup-To: hch@infradead.org, "Peter J. Braam" <braam@clusterfs.com>,
	torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
	'Phil Schwan' <phil@clusterfs.com>
References: <20040524114009.96CE13100E2@moraine.clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040524114009.96CE13100E2@moraine.clusterfs.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> vfs-intent_api-vanilla-2.6.patch
>  
>   Introduce intents for other operations.  Add a file system hook to
>   release intent data.  Make a few "intent versions" of functions such
>   as "lookup_one_len_it" and "user_walk_it" available through headers.
>   Arrange that the open intent is visible in the open methods. Add a
>   few missing intent_init calls.

I can't comment on the exact change, you need to talk to trond about
these.  But as-is they change the API exported to filesystems and thus
it's and absolute no-go for 2.6.   Where have you been when Trond's
intent patches went in?  Hiding under a rock?

