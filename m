Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281880AbRLKQsS>; Tue, 11 Dec 2001 11:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281893AbRLKQsJ>; Tue, 11 Dec 2001 11:48:09 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:19728 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S281880AbRLKQrx>;
	Tue, 11 Dec 2001 11:47:53 -0500
Date: Tue, 11 Dec 2001 17:47:44 +0100
From: Jens Axboe <axboe@suse.de>
To: Paul Larson <plars@austin.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Scsi problems in 2.5.1-pre9
Message-ID: <20011211164744.GC13498@suse.de>
In-Reply-To: <1008065277.25964.5.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1008065277.25964.5.camel@plars.austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11 2001, Paul Larson wrote:
> My hardware is a dual proc PII-300.  I was running LTP runalltests.sh
> and it was on one of the growfiles tests when this problem occurred. 
> The test hung, and I couldn't telnet into the machine or login to it,
> but I could switch between VC's.  On the console, I had screenfulls of
> errors like this:
> 
> Incorrect number of segments after building list
> counted 11, received 7

Attached patch should fix it.

-- 
Jens Axboe

