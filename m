Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269232AbTGZTsI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 15:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269291AbTGZTsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 15:48:08 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:55467 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S269232AbTGZTqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 15:46:24 -0400
Date: Sat, 26 Jul 2003 22:01:36 +0200
From: bert hubert <ahu@ds9a.nl>
To: VaX#n8 <vax@carolina.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: multiple readers for stack-processed net traffic
Message-ID: <20030726200135.GA16470@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	VaX#n8 <vax@carolina.rr.com>, linux-kernel@vger.kernel.org
References: <20030726185155.749E63006@carolina.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030726185155.749E63006@carolina.rr.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 26, 2003 at 02:51:55PM -0400, VaX#n8 wrote:
> Hi, I'd like to be able to create a second "tap" for application data that
> presents data exactly as the application sees it, and in such a way that
> guarantees that both applications read the data before it is freed or
> acknowledged.  I have skimmed the Coriolis book on the 2.0 IP stacks (yes,

Are you very sure you need this? I see heaps of issues. Why not do a
userspace proxy? Even that would not be trivial btw, you'd need to buffer
etc.

Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
