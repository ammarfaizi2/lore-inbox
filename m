Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWESJYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWESJYn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 05:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWESJYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 05:24:42 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16808 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751302AbWESJYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 05:24:42 -0400
To: Paul Jackson <pj@sgi.com>
Cc: Sam Vilain <sam@vilain.net>, akpm@osdl.org, serue@us.ibm.com,
       linux-kernel@vger.kernel.org, dev@sw.ru, herbert@13thfloor.at,
       devel@openvz.org, ebiederm@xmission.com, xemul@sw.ru,
       haveblue@us.ibm.com, clg@fr.ibm.com
Subject: Re: [PATCH 0/9] namespaces: Introduction
References: <20060518154700.GA28344@sergelap.austin.ibm.com>
	<20060518103430.080e3523.akpm@osdl.org> <446D0333.1020503@vilain.net>
	<20060518212417.e255349c.pj@sgi.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 19 May 2006 03:23:03 -0600
In-Reply-To: <20060518212417.e255349c.pj@sgi.com> (Paul Jackson's message of
 "Thu, 18 May 2006 21:24:17 -0700")
Message-ID: <m1ejyq1i88.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> writes:

>> Can anyone see any that are missed?
>
> I have no idea if this fits, as I am no virtual kernel wizard,
> but how about various NUMA stuff, such as what CPUs and Memory
> Nodes are online, and the three ways of controlling task and
> memory placement on them:
>   sched_setaffinity/sched_getaffinity
>   set_mempolicy/get_mempolicy/mbind
>   /dev/cpuset

I expect especially on very large machines for some of this to be done
in conjunction with setting up the isolated instances of user space. 
But anything actually touching the hardware is an independent dimension.

Eric

