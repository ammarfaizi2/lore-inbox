Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbWESR5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWESR5D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 13:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWESR5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 13:57:03 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:62707 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932408AbWESR5B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 13:57:01 -0400
Date: Fri, 19 May 2006 10:56:55 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: "Dr. David Alan Gilbert" <linux@treblig.org>
cc: linux-kernel@vger.kernel.org, John Richard Moser <nigelenki@comcast.net>
Subject: Re: Stealing ur megahurts (no, really)
In-Reply-To: <20060519173727.GA7947@gallifrey>
Message-ID: <Pine.LNX.4.62.0605191053310.2828@qynat.qvtvafvgr.pbz>
References: <446D61EE.4010900@comcast.net>  <20060519112218.GE19673@gallifrey>
 <446DFF25.4020301@comcast.net> <20060519173727.GA7947@gallifrey>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2006, Dr. David Alan Gilbert wrote:

>> Skews and fuzz.  Imperfections, but at least we get a general idea.  ;)
>
> Really? I bet there is a factor of 2 at least in that lot when you
> put them together? (Depending on what you are running)

however, in most cases the difference between the native machine and the 
thing you are testing for is a factor >20, so a fuzz factor of 2 still 
gets you pretty close.

> Remember the reason you are scrabbling around for this ancient machine
> is to answer a question along the lines of 'is my program useable on a
> .....' ?
> Also you want to make sure you haven't made an assumption about an actual
> feature (you left a cmov in somewhere? You assumed AGP? LBA block addressing
> etc).

if you need this level of detail you need the actual hardware or a 
hardware emulator. however there's a lot of 'is the performance 
reasonable' type testing that needs to be done (and useually needs to be 
done repeatedly, either with different performance settings or with 
after fixing performance issues) before you have to go to this step.

David Lang



-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

