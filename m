Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWFPWoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWFPWoV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 18:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbWFPWoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 18:44:21 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:57744 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S1751536AbWFPWoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 18:44:21 -0400
Date: Sat, 17 Jun 2006 00:44:06 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Goo GGooo <googgooo@gmail.com>, linux-kernel@vger.kernel.org,
       git@vger.kernel.org
Subject: Re: 2.6.17-rc6-mm2
Message-ID: <20060616224406.GA10451@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Linus Torvalds <torvalds@osdl.org>, Goo GGooo <googgooo@gmail.com>,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
References: <ef5305790606142040r5912ce58kf9f889c3d61b2cc0@mail.gmail.com> <ef5305790606151814i252c37c4mdd005f11f06ceac@mail.gmail.com> <Pine.LNX.4.64.0606151937360.5498@g5.osdl.org> <ef5305790606152249n2702873fy7b708d9c47c78470@mail.gmail.com> <Pine.LNX.4.64.0606152335130.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606152335130.5498@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2006 at 11:39:35PM -0700, Linus Torvalds wrote:

> Except they only work over ssh, where we have a separate channel (for 
> stderr), and with the native git protocol all that nice status work just 
> gets flushed to /dev/null :(

It won't help passing firewalls one bit, but you might consider using SCTP
with multiple datastreams for this - theoretically :-)

	Bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
