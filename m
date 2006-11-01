Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752248AbWKASOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbWKASOR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 13:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752250AbWKASOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 13:14:17 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:18587 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752247AbWKASOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 13:14:16 -0500
Date: Wed, 1 Nov 2006 23:49:26 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: David Rientjes <rientjes@cs.washington.edu>
Cc: Paul Menage <menage@google.com>, Paul Jackson <pj@sgi.com>, dev@openvz.org,
       sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-ID: <20061101181926.GD22976@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20061030103356.GA16833@in.ibm.com> <6599ad830610300251w1f4e0a70ka1d64b15d8da2b77@mail.gmail.com> <20061030031531.8c671815.pj@sgi.com> <6599ad830610300404v1e036bb7o7ed9ec0bc341864e@mail.gmail.com> <20061030042714.fa064218.pj@sgi.com> <6599ad830610300953o7cbf5a6cs95000e11369de427@mail.gmail.com> <20061030123652.d1574176.pj@sgi.com> <6599ad830610301247k179b32f5xa5950d8fc5a3926c@mail.gmail.com> <Pine.LNX.4.64N.0610311951280.7538@attu4.cs.washington.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0610311951280.7538@attu4.cs.washington.edu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 08:39:27PM -0800, David Rientjes wrote:
>  - How is forking handled with the various controllers?  Do child 
>    processes automatically inherit all the controller groups of its
>    parent?  If not (or if its dependant on a user-configured attribute

I think it would be simpler to go with the assumption that child process should 
automatically inherit the same resource controller groups as its parent.

Although I think, CKRM did attempt to provide the flexibility of
changing this behavior using rule-based classification engine (Matt/Chandra, 
correct me if I am wrong here).

-- 
Regards,
vatsa
