Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbTKZWg5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 17:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264331AbTKZWg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 17:36:57 -0500
Received: from pizda.ninka.net ([216.101.162.242]:45463 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261411AbTKZWg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 17:36:56 -0500
Date: Wed, 26 Nov 2003 14:36:20 -0800
From: "David S. Miller" <davem@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fire Engine??
Message-Id: <20031126143620.5229fb1f.davem@redhat.com>
In-Reply-To: <20031126232909.7e8a028f.ak@suse.de>
References: <BAY1-DAV15JU71pROHD000040e2@hotmail.com.suse.lists.linux.kernel>
	<20031125183035.1c17185a.davem@redhat.com.suse.lists.linux.kernel>
	<p73fzgbzca6.fsf@verdi.suse.de>
	<20031126113040.3b774360.davem@redhat.com>
	<3FC505F4.2010006@google.com>
	<20031126120316.3ee1d251.davem@redhat.com>
	<20031126232909.7e8a028f.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Nov 2003 23:29:09 +0100
Andi Kleen <ak@suse.de> wrote:

> The first SIOCGTSTAMP would be inaccurate, but the following (after 
> all untimestamped packets have been flushed) would be ok.

I don't think this is acceptable.  It's important that all
of the timestamps are as accurate as they were before.
