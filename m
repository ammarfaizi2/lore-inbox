Return-Path: <linux-kernel-owner+w=401wt.eu-S1750848AbWLNTmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWLNTmf (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 14:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbWLNTme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 14:42:34 -0500
Received: from brick.kernel.dk ([62.242.22.158]:12160 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750848AbWLNTme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 14:42:34 -0500
Date: Thu, 14 Dec 2006 20:43:59 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Steve Roemen <stever@carlislefsp.com>
Cc: LKML <linux-kernel@vger.kernel.org>, iss_storagedev@hp.com,
       mike.miller@hp.com
Subject: Re: 2.6.19-git20 cciss: cmd f7b00000 timedout
Message-ID: <20061214194358.GI5010@kernel.dk>
References: <45819939.3030701@carlislefsp.com> <20061214185112.GG5010@kernel.dk> <4581A748.5070509@carlislefsp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4581A748.5070509@carlislefsp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14 2006, Steve Roemen wrote:
>
> 2.6.19 does the same thing, except it's a cmd f7f00000 timedout error.<br>

Please don't send html only emails, that's just impossible to work with.

> 2.6.18 works just fine though.<br>

So the question is when it broke between 2.6.18 and 2.6.19. Can you try
and pin it down? Either use git bisect, or just start with the 2.6.19-rc
kernels and see which is the last one that works.

-- 
Jens Axboe

