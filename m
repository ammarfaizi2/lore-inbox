Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbUKWUHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbUKWUHo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 15:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbUKWUE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 15:04:59 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:45531 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261522AbUKWUEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 15:04:01 -0500
Subject: Re: [2.6 patch] MODULE_PARM_: remove the __deprecated
From: Lee Revell <rlrevell@joe-job.com>
To: Jim Nelson <james4765@verizon.net>
Cc: Adrian Bunk <bunk@stusta.de>, rusty@rustcorp.com.au,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <41A3147F.5030409@verizon.net>
References: <20041122155619.GG19419@stusta.de>
	 <1101188636.4245.2.camel@krustophenia.net>  <41A3147F.5030409@verizon.net>
Content-Type: text/plain
Date: Tue, 23 Nov 2004 15:03:58 -0500
Message-Id: <1101240239.6358.23.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-23 at 05:44 -0500, Jim Nelson wrote:
> Lee Revell wrote:
> > On Mon, 2004-11-22 at 16:56 +0100, Adrian Bunk wrote:
> > 
> >>MODULE_PARM_ might be deprecated.
> >>But there are still over 2000 places in the kernel where it's used.
> > 
> > 
> > Changing MODULE_PARM to module_param is not exactly rocket science.  You
> > could probably fix them all with a perl script.
> > 
> > Lee
> > 
> 
> Not really.  The permissions for the sysfs files, if nothing else, have to be done 
> manually.  Plus, check out:
> 

Well for every complex example like yours there is one like this:

http://lkml.org/lkml/2004/10/08/253

You would have to check the results of course.

Lee 


