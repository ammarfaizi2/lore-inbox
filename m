Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266001AbUG1Csm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266001AbUG1Csm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 22:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266155AbUG1Csm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 22:48:42 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:18425 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266001AbUG1Csj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 22:48:39 -0400
Message-ID: <410713FF.4090406@mvista.com>
Date: Tue, 27 Jul 2004 19:48:31 -0700
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: zanussi@us.ibm.com
CC: linux-kernel@vger.kernel.org, karim@opersys.com, richardj_moore@uk.ibm.com,
       bob@watson.ibm.com, michel.dagenais@polymtl.ca
Subject: Re: LTT user input
References: <16640.10183.983546.626298@tut.ibm.com>
In-Reply-To: <16640.10183.983546.626298@tut.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zanussi@us.ibm.com wrote:

> As with most other tools, we don't tend to hear from users unless they
> have problems with the tool. :-( LTT has also been picked up by
> Debian, SuSE, and MontaVista - maybe they have user input that we
> don't get to see as well...

I used LTT once to help investigate system startup performance issues on 
a Linux-based cell phone prototype.  One thing that might be different 
from most LTT user's experiences is that it was somebody else's 
software, for which I did not have the source.  This might help 
illustrate ways in which system administrators can analyze systems for 
improvements, rather than describing a more typical development 
scenario, although this does describe the development phase of a system.

LTT helped quantify the performance impacts of various system activities 
that might be best minimized (including unneeded system startup scripts 
and the importance of using shell builtins, as well as suggesting 
improvements that might be obtained through use of prelinking shared 
libraries), point out various repeated operations that could probably be 
consolidated (such as file access, process scheduling, and X 
client/server communication), and rule out low memory or the need for 
swapping as a cause of performance problems at that phase of system 
operation.

A great tool, highly recommended.

-- 
Todd Poynor
MontaVista Software

