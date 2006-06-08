Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWFHJgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWFHJgf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 05:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWFHJgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 05:36:35 -0400
Received: from gw.openss7.com ([142.179.199.224]:4800 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S964812AbWFHJgf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 05:36:35 -0400
Date: Thu, 8 Jun 2006 03:36:33 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, adilger@clusterfs.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use unlikely() for current_kernel_time() loop
Message-ID: <20060608033633.A16099@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
	adilger@clusterfs.com, linux-kernel@vger.kernel.org
References: <20060607173642.GA6378@schatzie.adilger.int> <200606080907.26350.ak@suse.de> <20060608025930.A15559@openss7.org> <200606081114.09390.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200606081114.09390.ak@suse.de>; from ak@suse.de on Thu, Jun 08, 2006 at 11:14:09AM +0200
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Thu, 08 Jun 2006, Andi Kleen wrote:
> 
> > performance increased 2% per hyperthread; 
> 
> That would surprise me. Most likely you made some measurement error.
> 

Don't think there was an error.  Tests performed on STREAMS external
modules optimized with profiling data.
