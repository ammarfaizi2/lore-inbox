Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbTEVVIw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 17:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263317AbTEVVIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 17:08:52 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:36878 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263315AbTEVVIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 17:08:50 -0400
Date: Thu, 22 May 2003 22:21:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Julien Oster <lkml@mf.frodoid.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69 won't mount root on md device
Message-ID: <20030522222133.A13552@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Julien Oster <lkml@mf.frodoid.org>, linux-kernel@vger.kernel.org
References: <frodoid.frodo.87y90yit5u.fsf@usenet.frodoid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <frodoid.frodo.87y90yit5u.fsf@usenet.frodoid.org>; from lkml@mf.frodoid.org on Thu, May 22, 2003 at 11:10:53PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 22, 2003 at 11:10:53PM +0200, Julien Oster wrote:
> can't mount root filesystem "901" or "/dev/md1"
> 
> (message typed from memory, no serial console currently available)
> 
> .config included. Any suggestions?

You are using devfs so you need to tell your kernel the devfs name
of the root device, /dev/md/1.  Or even better just turn devfs off.

