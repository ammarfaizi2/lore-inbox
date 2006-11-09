Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161776AbWKIFk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161776AbWKIFk2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 00:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161801AbWKIFk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 00:40:28 -0500
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:64194 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP
	id S1161776AbWKIFk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 00:40:27 -0500
Message-ID: <4552BF18.1060004@in.ibm.com>
Date: Thu, 09 Nov 2006 11:09:36 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com, menage@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
References: <20061031115342.GB9588@in.ibm.com>	<6599ad830610310846m5d718d22p5e1b569d4ef4e63@mail.gmail.com>	<20061101172540.GA8904@in.ibm.com>	<6599ad830611011537i2de812fck99822d3dd1314992@mail.gmail.com>	<20061106124948.GA3027@in.ibm.com>	<6599ad830611061223m77c0ef1ei72bd7729d9284ec6@mail.gmail.com>	<20061107104118.f02a1114.pj@sgi.com>	<6599ad830611071107u4226ec17h5facc7ee2ad53174@mail.gmail.com>	<6599ad830611071421s7792bbb1qd9c7b1fc840dfa50@mail.gmail.com>	<20061107191518.c094ce1a.pj@sgi.com>	<20061108051257.GB2964@in.ibm.com> <20061107213627.dc6ba1ce.pj@sgi.com>
In-Reply-To: <20061107213627.dc6ba1ce.pj@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Srivatsa wrote:
>> As was discussed in a previous thread, having a 'threads' file also will
>> be good.
>>
>> 	http://lkml.org/lkml/2006/11/1/386
>>
>> Writing to 'tasks' file will move that single thread to the new
>> container. Writing to 'threads' file will move all the threads of the
>> process into the new container.
> 
> Yup - agreed.
> 


Referring to the discussion at

	http://lkml.org/lkml/2006/10/31/210

Which lead to

	http://lkml.org/lkml/2006/11/1/101

If OpenVZ is ok with the notify_on_release approach, we can close in on
any further objections to the containers approach of implementing resource
grouping and be open to ideas for extending and enhancing it :)

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
