Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267350AbUJGIIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267350AbUJGIIB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 04:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269751AbUJGIIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 04:08:01 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:60840 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S267350AbUJGIEP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 04:04:15 -0400
Date: Thu, 7 Oct 2004 10:04:14 +0200
From: bert hubert <ahu@ds9a.nl>
To: Dan Kegel <dank@kegel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, joris@eljakim.nl
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041007080414.GA28999@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Dan Kegel <dank@kegel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	joris@eljakim.nl
References: <4164CB02.2030607@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4164CB02.2030607@kegel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 09:50:10PM -0700, Dan Kegel wrote:

> It would be nice to know how other operating systems behave
> when receiving UDP packets with bad checksums.  Can someone
> try BSD and Solaris?

It does not matter - this behaviour should not be depended upon. There are
lots of other reasons why a packet might in fact not be available, kernels
are allowed to drop UDP packets at will.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
