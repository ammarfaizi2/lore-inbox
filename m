Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263394AbUDGNXR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 09:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbUDGNXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 09:23:17 -0400
Received: from ns.suse.de ([195.135.220.2]:28316 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263394AbUDGNXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 09:23:13 -0400
Subject: Re: [PATCH] reiserfs v3 fixes and features
From: Chris Mason <mason@suse.com>
To: Yury Umanets <yury@clusterfs.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1081343178.3042.2.camel@firefly>
References: <1081274618.30828.30.camel@watt.suse.com>
	 <1081343178.3042.2.camel@firefly>
Content-Type: text/plain
Message-Id: <1081344323.30829.534.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 07 Apr 2004 09:25:23 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-07 at 09:06, Yury Umanets wrote:

> That would be nice to have also improved locking in this
> features-improvements-fixes patch set. Ask Oleg, he had intention to
> work on and probably has something done already.
> 

I'm assuming you mean getting rid of the BKL, which would be really
nice.  I'd like to get the current patchset stabilized and in the
kernel, but even moving to a per fs spin lock instead of the bkl would
be a welcome change.

-chris

