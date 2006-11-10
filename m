Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946538AbWKJMlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946538AbWKJMlG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 07:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946539AbWKJMlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 07:41:06 -0500
Received: from cantor.suse.de ([195.135.220.2]:29342 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1946538AbWKJMlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 07:41:03 -0500
From: Andi Kleen <ak@suse.de>
To: Andre Noll <maan@systemlinux.org>
Subject: Re: 2.6.19-rc5: Bad page state in process 'swapper'
Date: Fri, 10 Nov 2006 13:40:56 +0100
User-Agent: KMail/1.9.5
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
References: <20061110121151.GC29040@skl-net.de>
In-Reply-To: <20061110121151.GC29040@skl-net.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611101340.56161.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 November 2006 13:11, Andre Noll wrote:
> Hi
> 
> just tried to boot 2.6.19-rc5 on a 2-way opteron 250 with 8G Ram:

Do you have the earliest kernel messages still in the log buffer (e820 map etc.)?
If yes can we see them.
 
Did any earlier kernel work? 
What is your .config?

Does it help when you apply 

ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/e820-small-entries ? 

-Andi
