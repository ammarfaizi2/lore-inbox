Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264911AbTIJGqY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 02:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264912AbTIJGqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 02:46:24 -0400
Received: from holomorphy.com ([66.224.33.161]:432 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264911AbTIJGqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 02:46:23 -0400
Date: Tue, 9 Sep 2003 23:47:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Hu, Boris" <boris.hu@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Split futex global spinlock futex_lock
Message-ID: <20030910064727.GN4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Hu, Boris" <boris.hu@intel.com>, linux-kernel@vger.kernel.org
References: <37FBBA5F3A361C41AB7CE44558C3448E01C0B69E@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37FBBA5F3A361C41AB7CE44558C3448E01C0B69E@pdsmsx403.ccr.corp.intel.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 01:23:47PM +0800, Hu, Boris wrote:
> Split futex global spinlock futex_lock into hash bucket spinlocks.
> Add bucket spinlock recursively lock check fixed by Jakub Jelinek.

This looks nice and straightforward. How much did it speed up the
benchmarks?


-- wli
