Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030499AbWEYWja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030499AbWEYWja (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 18:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030500AbWEYWj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 18:39:29 -0400
Received: from sccrmhc13.comcast.net ([63.240.77.83]:25278 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1030499AbWEYWj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 18:39:29 -0400
Message-ID: <4476321A.8090508@opensound.com>
Date: Thu, 25 May 2006 15:39:22 -0700
From: 4Front Technologies <dev@opensound.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.2) Gecko/20060404 SeaMonkey/1.0.1
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to check if kernel sources are installed on a system?
References: <e55715+usls@eGroups.com> <1148596163.31038.30.camel@mindpipe>
In-Reply-To: <1148596163.31038.30.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Thu, 2006-05-25 at 21:19 +0000, devmazumdar wrote:
>> How does one check the existence of the kernel source RPM (or deb) on
>> every single distribution?.
>>
>> We know that rpm -qa | grep kernel-source works on Redhat, Fedora,
>> SuSE, Mandrake and CentOS - how about other RPM based distros? How
>> about debian based distros?. There doesn't seem to be a a single
>> conherent naming scheme.  
> 
> I'd really like to see a distro-agnostic way to retrieve the kernel
> configuration.  /proc/config.gz has existed for soem time but many
> distros inexplicably don't enable it.
> 
> Lee
> 
> 

A-men to that!. Basically what really needs to happen is for all the distros to 
adopt Fedora's way of shipping kernel headers. If you're not going to ship 
source for the kernel, atleast ship kernel headers for the kernel that you are 
running.


Anything to get out-of-kernel modules compiling without jumping through 1000 
hoops is good.



best regards
Dev Mazumdar
-----------------------------------------------------------
4Front Technologies
4035 Lafayette Place, Unit F, Culver City, CA 90232, USA.
Tel: (310) 202 8530		URL: www.opensound.com
Fax: (310) 202 0496 		Email: info@opensound.com
-----------------------------------------------------------
