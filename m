Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752656AbWKBIq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656AbWKBIq7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 03:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752723AbWKBIq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 03:46:59 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:64106 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1752656AbWKBIq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 03:46:58 -0500
Message-ID: <4549AF81.2060706@openvz.org>
Date: Thu, 02 Nov 2006 11:42:41 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Pavel Emelianov <xemul@openvz.org>, dev@openvz.org, sekharan@us.ibm.com,
       menage@google.com, ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org, pj@sgi.com,
       matthltc@us.ibm.com, dipankar@in.ibm.com, rohitseth@google.com,
       devel@openvz.org
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
References: <20061030103356.GA16833@in.ibm.com> <45460743.8000501@openvz.org> <20061031163418.GD9588@in.ibm.com> <4548545B.4070701@openvz.org> <20061101175015.GA22976@in.ibm.com>
In-Reply-To: <20061101175015.GA22976@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> On Wed, Nov 01, 2006 at 11:01:31AM +0300, Pavel Emelianov wrote:
>>> Sorry dont get you here. Are you saying we should support different
>>> grouping for different controllers?
>> Not me, but other people in this thread.
> 
> Hmm ..I thought OpenVz folks were interested in having different
> groupings for different resources i.e grouping for CPU should be
> independent of the grouping for memory.
> 
> 	http://lkml.org/lkml/2006/8/18/98
> 
> Isnt that true?

That's true. We don't mind having different groupings for
different resources. But what I was sying in this thread is
"I didn't *propose* this thing, I just *agreed* that this
might be usefull for someone."

So if we're going to have different groupings for different
resources what's the use of "container" grouping all "controllers"
together? I see this situation like each task_struct carries
pointers to kmemsize controller, pivate pages controller,
physical pages controller, CPU time controller, disk bandwidth
controller, etc. Right? Or did I miss something?
