Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263888AbTJEV6G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 17:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263890AbTJEV6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 17:58:05 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:23571
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S263888AbTJEV6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 17:58:02 -0400
Date: Sun, 5 Oct 2003 14:58:03 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Justin Hibbits <jrh29@po.cwru.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: regression between 2.4.18 and 2.4.21/22
Message-ID: <20031005215803.GF1205@matchmail.com>
Mail-Followup-To: Justin Hibbits <jrh29@po.cwru.edu>,
	linux-kernel@vger.kernel.org
References: <7342FA76-F771-11D7-86F4-000A95841F44@po.cwru.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7342FA76-F771-11D7-86F4-000A95841F44@po.cwru.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 05, 2003 at 04:21:06PM -0400, Justin Hibbits wrote:
> which now get sustained transfer rates of 46MB/s or greater.  I'm using 
> the same options for all 3 kernels (at least, for the ATA/IDE options). 
>  Any help would be appreciated, and I'll see if maybe I could do 
> something with it when I get time.

Some drivers have been split, or renamed.  Make sure you have the driver for
your chipset compiled in, and you're not using generic ide dma.
