Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262771AbVFWS3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbVFWS3K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 14:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262812AbVFWS3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 14:29:10 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:42430 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262771AbVFWS27
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 14:28:59 -0400
Message-ID: <42BAFF62.708@us.ibm.com>
Date: Thu, 23 Jun 2005 11:28:50 -0700
From: Vara Prasad <prasadav@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
CC: linux <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Script to help users to report a BUG
References: <4d8e3fd30506191332264eb4ae@mail.gmail.com>
In-Reply-To: <4d8e3fd30506191332264eb4ae@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ciarrocchi wrote:

>Hi all,
>what do you think about this simple idea of a script that could help
>users to fill better BUG reports ?
>
>The usage is quite simple, put the attached file in
>/usr/src/linux/scripts and then:
>
>[root@frodo scripts]# ./report-bug.sh /tmp/BUGREPORT/
>cat: /proc/scsi/scsi: No such file or directory
>
>[root@frodo scripts]# ls /tmp/BUGREPORT/
>cpuinfo.bug  ioports.bug  modules.bug  software.bug
>iomem.bug    lspci.bug    scsi.bug     version.bug
>
>Now you can simply attach all the .bug files to the bugzilla report or
>inline them in a email.
>
>The script is rude but it is enough to give you an idea of what I have in mind.
>
>Any comment ?
>
>
>  
>
Hi,

We have a need for similar tool so that customers using Linux system can 
report the problem with as much information as they can about their 
system for someone to diagnose the problem efficiently. Customers wanted 
to run this one tool which gathers most useful information for all kinds 
of problems. To help in this process we have a tool developed by local 
university students. I would say the tool is in prototype stage. You can 
download the tool from the project website at 
http://sourceforge.net/projects/projectsynfo.

Is the information this tool collects meets the need for what is 
discussed here?
If not what changes you would like to see in the data collected?

Currently the tool is written in "C",  if people don't like this to be 
implemented in "C", please suggest the alternatives and we can make the 
required changes.

Thanks,
Vara Prasad

