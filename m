Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265049AbUGHOBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265049AbUGHOBs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 10:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263972AbUGHOBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 10:01:36 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:40358 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261763AbUGHOB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 10:01:26 -0400
Date: Thu, 8 Jul 2004 07:52:04 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jakub Jelinek <jakub@redhat.com>
Cc: tom st denis <tomstdenis@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Prohibited attachment type (was 0xdeadbeef)
Message-ID: <20040708055204.GF5054@openzaurus.ucw.cz>
References: <Pine.LNX.4.53.0407070715380.17430@chaos> <20040707114836.29295.qmail@web41103.mail.yahoo.com> <20040707122916.GH21264@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040707122916.GH21264@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> It is certainly not obscure.
> ISO C99 6.4.4.1#5 says:
> The type of an integer constant is the first of the corresponding list in
> which its value can be represented.
> 
> For Octal or Hexadecimal Constant and no suffix, the table lists:
> int
> unsigned int
> long int
> unsigned long int
> long long int
> unsigned long long int
> 
> Assuming 32-bit int, 0xdeadbeef has unsigned int type.
> 
> For Decimal Constant and no suffix, the table lists only:
> int
> long int
> long long int
> and thus assuming 32-bit int and 64-bit long, 3735928559 has long int type,
> assuming 32-bit int, 32-bit long and 64-bit long long, 3735928559 has long
> int type.

Did you mean "long long int" at the end of last sentence?
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

