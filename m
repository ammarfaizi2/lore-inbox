Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbWDMUWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbWDMUWz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 16:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbWDMUWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 16:22:55 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:27793 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S964965AbWDMUWy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 16:22:54 -0400
Date: Thu, 13 Apr 2006 12:22:26 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
cc: "Martin J. Bligh" <mbligh@mbligh.org>, K P <kplkml@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: JVM performance on Linux (vs. Solaris/Windows)
In-Reply-To: <443EBC1D.1000307@wolfmountaingroup.com>
Message-ID: <Pine.LNX.4.62.0604131220560.15794@qynat.qvtvafvgr.pbz>
References: <62a080740604130753i4b8bbbckc3cba12092b54226@mail.gmail.com> 
 <443E74C1.5090801@mbligh.org> <443EBC1D.1000307@wolfmountaingroup.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2006, Jeff V. Merkey wrote:

> Note they ran the benchmark on an Opteron 285 instead of a Xeon with 16 GB of 
> memory.    Opteron peformance currently **SUCKS** with 2.6 series kernels 
> under any kind of heavy I/O due to their cloning of the ancient 82489DX 
> architecture for I/O interrupt access and performance.  Looks like the test 
> was stakced against Linux from the start.  Should have used a Xeon system. 
> AMD needs to get their crappy I/O performance up to snuff.  Looking at the 
> test parameteres leads me to believe there was a lot of swapping on a system 
> with already poor I/O performance.

Jeff, I've seen several reccomendations from databasefolks (postgres and 
mysql) favoring Opterons over Xeons. this doesn't match your statement 
that Opteron performance sucks under any kind of I/O load. I don't 
understand how both can be correct.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

