Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264325AbUASWYk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 17:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264361AbUASWYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 17:24:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53200 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264325AbUASWYg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 17:24:36 -0500
Date: Mon, 19 Jan 2004 22:24:34 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: john moser <bluefoxicy@linux.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: struct task_struct -> task_t
Message-ID: <20040119222434.GO21151@parcelfarce.linux.theplanet.co.uk>
References: <20040119221757.411BB3958@sitemail.everyone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040119221757.411BB3958@sitemail.everyone.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 02:17:57PM -0800, john moser wrote:
> It has come to my attention that in some places in the kernel, 'struct task_struct'
> is used; and in others, 'task_t' is used.  Also, 'task_t' is
> 'typedef struct task_struct task_t;'.
> 
> I made a small script to change around as much as I could so that everything uses
> task_t,

What the fsck for?  If anything, the opposite (and removal of that typedef)
would be preferable.
