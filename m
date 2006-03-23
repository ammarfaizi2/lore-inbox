Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWCWNXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWCWNXe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 08:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWCWNXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 08:23:34 -0500
Received: from dvhart.com ([64.146.134.43]:47292 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S932071AbWCWNXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 08:23:33 -0500
Message-ID: <4422A155.8070207@mbligh.org>
Date: Thu, 23 Mar 2006 05:23:33 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ck] swap prefetching merge plans
References: <20060322205305.0604f49b.akpm@osdl.org> <200603231804.36334.kernel@kolivas.org> <200603230901.57052.jos@mijnkamer.nl> <44225AB4.4080503@yahoo.com.au>
In-Reply-To: <44225AB4.4080503@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Firstly, swap prefetch actually doesn't handle the midnight updatedb
pageout
> problem nicely. It doesn't do any prefetching when the pagecache/vfs 
> cache fills memory (which is what would have to happen for updatedb 
> to push stuff into swap).

So is use once just horribly broken, or is updatedb reading everything
multiple times for some reason?

M.


