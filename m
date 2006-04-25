Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWDYTN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWDYTN6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 15:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWDYTN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 15:13:58 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:7945 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S932296AbWDYTN5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 15:13:57 -0400
Message-ID: <444E74ED.6090306@argo.co.il>
Date: Tue, 25 Apr 2006 22:13:49 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Michael Poole <mdpoole@troilus.org>
CC: Valdis.Kletnieks@vt.edu, dtor_core@ameritech.net,
       Kyle Moffett <mrmacman_g4@mac.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>	<1145911546.1635.54.camel@localhost.localdomain>	<444D3D32.1010104@argo.co.il>	<A6E165E4-8D43-4CF8-B48C-D4B0B28498FB@mac.com>	<444DCAD2.4050906@argo.co.il>	<9E05E1FA-BEC8-4FA8-811E-93CBAE4D47D5@mac.com>	<444E524A.10906@argo.co.il>	<d120d5000604251010kd56580fl37a0d244da1eaf45@mail.gmail.com>	<444E5A3E.1020302@argo.co.il>	<d120d5000604251028h67e552ccq7084986db6f1cdeb@mail.gmail.com>	<444E61FD.7070408@argo.co.il>	<200604251808.k3PI8Y06004736@turing-police.cc.vt.edu>	<444E69E7.7020808@argo.co.il> <444E6CBD.5020904@argo.co.il> <87hd4hh4hw.fsf@graviton.dyn.troilus.org>
In-Reply-To: <87hd4hh4hw.fsf@graviton.dyn.troilus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Apr 2006 19:13:56.0353 (UTC) FILETIME=[6615CF10:01C6689C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Poole wrote:
>> How many of these leave something out? how much time is spent
>> deciphering the code when something goes wrong, or is even suspected?
>>     
>
> Probably fewer cases and less time than you suspect, respectively.
> Just as C++ gives you tools, C does too, but far more important than
> language tools is the discipline used when writing code: discipline to
> think through the code, to structure it rationally, and to reuse the
> rational structures that others have devised in the past.  C++ gives
> you well-tested helper classes to manage object locking.  Linux gives
> you its own well-tested examples of known and tried design patterns.
>   
I agree. It certainly helps when you first write the code. But it's 
still difficult to read and modify the code. And I'd prefer to see the 
effort involved in coding to these patterns and in enforcing them used 
to other purposes.

I also suspect drivers are written with less rigor.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

