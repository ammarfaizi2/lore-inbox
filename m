Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbTJJQsJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 12:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbTJJQsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 12:48:09 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:17505 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263053AbTJJQsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 12:48:06 -0400
Date: Fri, 10 Oct 2003 17:47:47 +0100
From: Dave Jones <davej@redhat.com>
To: Thom Borton <borton@phys.ethz.ch>
Cc: Russell King <rmk@arm.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: PCMCIA CD-ROM does not work
Message-ID: <20031010164747.GG25856@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Thom Borton <borton@phys.ethz.ch>,
	Russell King <rmk@arm.linux.org.uk>,
	lkml <linux-kernel@vger.kernel.org>
References: <200310101652.53796.borton@phys.ethz.ch> <200310101744.30827.borton@phys.ethz.ch> <20031010162710.GF25856@redhat.com> <200310101843.17341.borton@phys.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310101843.17341.borton@phys.ethz.ch>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 06:43:17PM +0200, Thom Borton wrote:

 > You were both right. With CONFIG_ISA the system does not hang when I 
 > plug in the PCMCIA card, but I cannot mount it later. 
 > 
 > What can I do then?

Binary search to find the exact pre that broke this would be
a good start.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
