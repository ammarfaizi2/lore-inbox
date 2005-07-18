Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbVGRObk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVGRObk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 10:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVGRObj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 10:31:39 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:57507 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261757AbVGRObj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 10:31:39 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17115.48448.238359.451882@tut.ibm.com>
Date: Mon, 18 Jul 2005 09:31:28 -0500
To: Hareesh Nagarajan <hareesh@google.com>
Cc: Tom Zanussi <zanussi@us.ibm.com>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, karim@opersys.com, varap@us.ibm.com,
       richardj_moore@uk.ibm.com
Subject: Re: Merging relayfs?
In-Reply-To: <42DB3B59.1080006@google.com>
References: <17107.6290.734560.231978@tut.ibm.com>
	<20050712022537.GA26128@infradead.org>
	<20050711193409.043ecb14.akpm@osdl.org>
	<Pine.LNX.4.61.0507131809120.3743@scrub.home>
	<17110.32325.532858.79690@tut.ibm.com>
	<Pine.LNX.4.61.0507171551390.3728@scrub.home>
	<17114.32450.420164.971783@tut.ibm.com>
	<42DB3B59.1080006@google.com>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hareesh Nagarajan writes:
 > Tom Zanussi wrote:
 > > Roman Zippel writes:
 > >  > Hi,
 > >  > 
 > >  > On Thu, 14 Jul 2005, Tom Zanussi wrote:
 > >  > 
 > >  > > The netlink control channel seems to work very well, but I can
 > >  > > certainly change the examples to use something different.  Could you
 > >  > > suggest something?
 > >  > 
 > >  > It just looks like a complicated way to do an ioctl, a control file that 
 > >  > you can read/write would be a lot simpler and faster.
 > > 
 > > You're right - in previous versions, we did use ioctl - we ended up
 > > using netlink as it seemed like least offensive option to most people.
 > > I'll try modifying the example code to use a control file or something
 > > like that instead though.
 > 
 > Having an ioctl() interface will definitely make things less 
 > complicated. Are the older versions which use ioctl available off the 
 > relayfs website?

Yes, the 'old relayfs' patches on the website implement ioctl.

Tom


