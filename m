Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbTICHip (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 03:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbTICHip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 03:38:45 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:43791
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261469AbTICHio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 03:38:44 -0400
Date: Wed, 3 Sep 2003 00:38:58 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org, lm@bitmover.com
Subject: Re: Scaling noise
Message-ID: <20030903073858.GB15765@matchmail.com>
Mail-Followup-To: John Bradford <john@grabjohn.com>,
	linux-kernel@vger.kernel.org, lm@bitmover.com
References: <200309030710.h837AXnR000500@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309030710.h837AXnR000500@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 08:10:33AM +0100, John Bradford wrote:
> boxes, but no Linux image will run on more than $smallnum virtual
> CPUs.

Which is exactly what Larry is advocating.  Essencially, instead of having
one large image covering a large NUMA box, you have several images covering
each NUMA node (even if they're in the same box).
