Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbWCQTBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbWCQTBj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 14:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbWCQTBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 14:01:39 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:16285 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1030262AbWCQTBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 14:01:39 -0500
Date: Fri, 17 Mar 2006 11:01:38 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: linux-kernel@vger.kernel.org
Subject: Re: uml build problem 2.6.15.6/2.6.16rc6
In-Reply-To: <Pine.LNX.4.62.0603161831480.12573@qynat.qvtvafvgr.pbz>
Message-ID: <Pine.LNX.4.62.0603171100110.13995@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.62.0603161831480.12573@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2006, David Lang wrote:

> I'm attempting to build a UML kernel on both versions (same starting config 
> before make ARCH-um oldconfig) and I get the following error on 2.6.16rc6 
> (similar errors on 2.6.15.6)

my bad, I had done
make ARCH=um clean
make ARCH=um oldconfig
make ARCH=um -j8

but I hadn't done
make ARCH=um mrproper

doing that and then pulling in the old config and going from there seems 
to be working.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

