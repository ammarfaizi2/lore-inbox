Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbWAJSqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbWAJSqg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 13:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWAJSqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 13:46:35 -0500
Received: from dvhart.com ([64.146.134.43]:4737 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S932525AbWAJSqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 13:46:34 -0500
Message-ID: <43C40104.3060209@mbligh.org>
Date: Tue, 10 Jan 2006 10:46:28 -0800
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Jens Axboe <axboe@suse.de>,
       Byron Stanoszek <gandalf@winds.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2G memory split
References: <20060110125852.GA3389@suse.de> <20060110132957.GA28666@elte.hu> <20060110133728.GB3389@suse.de> <Pine.LNX.4.63.0601100840400.9511@winds.org> <20060110143931.GM3389@suse.de> <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org> <43C3F986.4090209@mbligh.org> <Pine.LNX.4.64.0601101028360.4939@g5.osdl.org> <43C3E74D.7060309@wolfmountaingroup.com>
In-Reply-To: <43C3E74D.7060309@wolfmountaingroup.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No. It works fine (or seems to) with 2:2 mapping. I've tested with these 
> extensively
> and am shipping products on the 1U appliances with 2:2 and I have never 
> seen any problems
> with 2.6.9-2.6.13.

Thanks, that helps.

> The only unpleasant side affect with 3:1 is user apps seem to rely on 
> swap space
> a little more than I like -- perhaps this is the side affect you are 
> referring to?
> 
> RH ES uses 4:4 which is ideal and superior to this hack.

Ideal in that it's universally slower, and most people don't need it? 
;-) 4:4 is a workaround for a very specialized, and rare situation.

M.
