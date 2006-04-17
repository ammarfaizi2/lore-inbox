Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWDQQTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWDQQTW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 12:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWDQQTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 12:19:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23745 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751035AbWDQQTV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 12:19:21 -0400
Date: Mon, 17 Apr 2006 09:19:15 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: George Nychis <gnychis@cmu.edu>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: want to randomly drop packets based on percent
Message-ID: <20060417091915.67e28361@localhost.localdomain>
In-Reply-To: <444345F9.4090100@cmu.edu>
References: <444345F9.4090100@cmu.edu>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2006 03:38:33 -0400
George Nychis <gnychis@cmu.edu> wrote:

> Hey,
> 
> I'm using the 2.4.32 kernel with madwifi and iproute2 version 
> 2-2.6.16-060323.tar.gz
> 
> I wanted to insert artificial packet loss based on a percent so i found:
> network emulab qdisc could do it, so i compiled support into the kernel 
> and tried:
> tc qdisc change dev eth0 root netem loss .1%

Most likely, you the version of the kernel you are running was not
configured with netem enabled.
