Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbWCYXQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbWCYXQx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 18:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWCYXQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 18:16:53 -0500
Received: from stark.xeocode.com ([216.58.44.227]:22215 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S1751031AbWCYXQv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 18:16:51 -0500
To: yang.y.yi@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, arjan@infradead.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, johnpol@2ka.mipt.ru,
       matthltc@us.ibm.com
Subject: Re: Connector: Filesystem Events Connector v3
References: <4423673C.7000008@gmail.com>
	<1143183541.2882.7.camel@laptopd505.fenrus.org>
	<20060323.230649.11516073.davem@davemloft.net>
	<4c4443230603240614m5f495340y9dc6ccc45e1e45b4@mail.gmail.com>
In-Reply-To: <4c4443230603240614m5f495340y9dc6ccc45e1e45b4@mail.gmail.com>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 25 Mar 2006 18:16:32 -0500
Message-ID: <8764m2i08f.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


yang.y.yi@gmail.com writes:

> the filesystem events connector is small and has low overhead, it only
> focuses on activities in the filesystem, so I think it should be an option
> for those users which just concerns events in the filesystem. audit dose do
> this, but it is complicated and overhead is big, I believe the filesystem
> events connector is useful, but it maybe need to be improved further.

Would this be a good tool to tell me why I hear my hard drive stutter
periodically? This is above the regular buffer flushing. 

I'm curious what application is causing this file i/o since I have plenty of
free RAM so the only reason it would be hitting disk is if something is
calling fsync gratuitously.

-- 
greg

