Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274882AbTHFLCT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 07:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274996AbTHFLCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 07:02:19 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:37303 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S274882AbTHFLCR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 07:02:17 -0400
Date: Wed, 6 Aug 2003 13:02:16 +0200
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: nfs/nfsd gets stuck on a write
Message-ID: <20030806110215.GA30936@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
References: <20030806104612.GB703@wiggy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030806104612.GB703@wiggy.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 12:46:13PM +0200, Wichert Akkerman wrote:
> I seem to have hit a nfs problem between two 2.6.0-test2 machines. 
> Mounting works properly, but at some point when logging in with /home
> over NFS things get stuck. A tcpdump reveals the following:

I've had problems like that go away by explicitly mounting -o tcp. 

> Both machines have a similar configuration: 2.6.0-test2 with NFS and NFS
> over TCP enabled. There are no firewalls blocking traffic between those
> two machines.

Your dump shows UDP, so give it a try.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
