Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbTIKRdj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 13:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbTIKRcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 13:32:04 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:40714
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261434AbTIKR2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 13:28:48 -0400
Date: Thu, 11 Sep 2003 10:28:50 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Valdis.Kletnieks@vt.edu
Cc: Breno Silva <brenosp@brasilsec.com.br>, Stan Bubrouski <stan@ccs.neu.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: Size of Tasks during ddos
Message-ID: <20030911172850.GC18399@matchmail.com>
Mail-Followup-To: Valdis.Kletnieks@vt.edu,
	Breno Silva <brenosp@brasilsec.com.br>,
	Stan Bubrouski <stan@ccs.neu.edu>, linux-kernel@vger.kernel.org
References: <001b01c39047$d65cf580$f8e4a7c8@bsb.virtua.com.br> <20030911002755.GA13177@triplehelix.org> <3F5FD993.2060900@ccs.neu.edu> <009201c37860$f0d3c5f0$131215ac@poslab219> <200309111419.h8BEJbSo010948@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309111419.h8BEJbSo010948@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 10:19:37AM -0400, Valdis.Kletnieks@vt.edu wrote:
> The answer will differ depending whether (for example) you're being ICMP
> flooded, SYN-flooded, hit with a mass of HTTP 'GET /' commands, hit with a mass
> of HTTP commands that invoke a resource-intensive CGI like a database search,
> and so on.
> 
> We'd really need to know what the traffic involved in the DDoS is in order to
> be able to comment on memory usage.

True, but it's not a ddos unless they do everything they can to disable the
target system.  Sure they could just flood your net pipe, but why do that
when you could have fewer senders and completely kill the box for a long
time while it tries to process all of your requests (assuming you're running
services accessable from the net).
