Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbWJBQFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbWJBQFK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 12:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965021AbWJBQFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 12:05:10 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:5119 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S965018AbWJBQFJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 12:05:09 -0400
Date: Mon, 2 Oct 2006 08:48:51 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Phillip Susi <psusi@cfl.rr.com>
cc: Willy Tarreau <w@1wt.eu>, Drew Scott Daniels <ddaniels@UMAlumni.mb.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: Smaller compressed kernel source tarballs?
In-Reply-To: <45212D5D.7010201@cfl.rr.com>
Message-ID: <Pine.LNX.4.63.0610020848070.28876@qynat.qvtvafvgr.pbz>
References: <20061002033511.GB12695@zimmer> <20061002033531.GA5050@1wt.eu> 
 <Pine.LNX.4.63.0610012205280.28534@qynat.qvtvafvgr.pbz> <45212D5D.7010201@cfl.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Oct 2006, Phillip Susi wrote:

> David Lang wrote:
>> I just had what's probably a silly thought.
>> 
>> as an alturnative to useing tar, what about useing a git pack?
>> 
>> create a git archive with no history, just the current files, and then pack 
>> it with agressive delta options.
>> 
>
> Isn't that what a patch.gz is?  Diff generates the deltas and then they are 
> compressed.  Can't get much simpler or better than that.

not quite, a git pack includes everythign you need to get the full source, a 
patch.gz requires that you have the prior version of the source to start with.

David Lang
