Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbVCNUUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbVCNUUk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 15:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVCNUUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 15:20:40 -0500
Received: from smtp.uninet.ee ([194.204.0.4]:14 "EHLO smtp.uninet.ee")
	by vger.kernel.org with ESMTP id S261870AbVCNUUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 15:20:12 -0500
Message-ID: <4235F1FA.6090007@tuleriit.ee>
Date: Mon, 14 Mar 2005 22:20:10 +0200
From: Indrek Kruusa <indrek.kruusa@tuleriit.ee>
Reply-To: indrek.kruusa@tuleriit.ee
User-Agent: Mozilla Thunderbird 0.8 (X11/20040923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Building server-farm
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > I'm looking for a way to connect multiple linux systems
 > into one big machine (server-farm) and I can't find any
 > way of enabling it in kernel.

It seems that you have to analyse your problem a bit more.

There are 5 main types of clusters (or server-farms as you call it):
- parallel computing
- high availability
- load balancing
- storage cluster
- database cluster

Of course these overlap in functionality but so they say :) In many 
cases those goals are achievable with "share nothing" in kernel level: 
lam/mpi, ipvs, hartbeat, lvm etc. Well, about filesystems I am not sure 
at moment :)

Please analyse your need to create "as it was one big machine" because 
maybe it is not the solution you really need.

thanks,
Indrek

