Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVDYWqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVDYWqz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 18:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVDYWqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 18:46:55 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11741 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261253AbVDYWqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 18:46:53 -0400
Date: Tue, 26 Apr 2005 00:46:33 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 1a/7] dlm: core locking
Message-ID: <20050425224633.GA17540@elf.ucw.cz>
References: <20050425165705.GA11938@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425165705.GA11938@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The core dlm functions.  Processes dlm_lock() and dlm_unlock() requests.
> Creates lockspaces which give applications separate contexts/namespaces in
> which to do their locking.  Manages locks on resources' grant/convert/wait
> queues.  Sends and receives high level locking operations between nodes.
> Delivers completion and blocking callbacks (ast's) to lock holders.
> Manages the distributed directory that tracks the current master node for
> each resource.

dlm stands for "distributed lock manager"? Is this component of lustre
or what


> +/******************************************************************************
> +*******************************************************************************
> +**
> +**  Copyright (C) Sistina Software, Inc.  1997-2003  All rights reserved.
> +**  Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
> +**
> +**  This copyrighted material is made available to anyone wishing to use,
> +**  modify, copy, or redistribute it subject to the terms and conditions
> +**  of the GNU General Public License v.2.
> +**
> +*******************************************************************************
> +******************************************************************************/

I'd read this as GPL v0.2. You have one dot too many... Also it would
be nice to use less stars, as other kernel sources do...

								Pavel

-- 
Boycott Kodak -- for their patent abuse against Java.
