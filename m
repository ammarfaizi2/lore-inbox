Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262854AbTJJPJZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 11:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262861AbTJJPJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 11:09:25 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:48111 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S262854AbTJJPJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 11:09:23 -0400
Date: Fri, 10 Oct 2003 16:09:16 +0100
From: Dave Jones <davej@redhat.com>
To: Thom Borton <borton@phys.ethz.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCMCIA CD-ROM does not work
Message-ID: <20031010150916.GA32600@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Thom Borton <borton@phys.ethz.ch>, linux-kernel@vger.kernel.org
References: <200310101652.53796.borton@phys.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310101652.53796.borton@phys.ethz.ch>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 04:52:50PM +0200, Thom Borton wrote:
 > 
 > Hello everybody
 > 
 > I have a Sony Vaio PCG-Z600NE with an external PCMCIA 4x CD-ROM drive, 
 > which used to work perfectly until around 2.4.18. With later kernels 
 > I did not succeed to get it running. I tried extensively with 2.4.22. 
 > As far as I remember, 2.4.19-21 did not work either.
 > 
 > I have attached the syslogs for 2.4.18, 2.4.22 and 2.6.0-test7.
 > 
 > Any idea what's wrong? Thanks for the help.

I'm not sure what broke it, but if you boot with "ide1=0x386,0x180 pci=off"
it works again.  Not a perfect solution, but until someone does some
digging to find out exactly when it broke, we're stuck.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
