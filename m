Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWESEYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWESEYm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 00:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWESEYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 00:24:42 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:52966 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932224AbWESEYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 00:24:42 -0400
Date: Thu, 18 May 2006 21:24:17 -0700
From: Paul Jackson <pj@sgi.com>
To: Sam Vilain <sam@vilain.net>
Cc: akpm@osdl.org, serue@us.ibm.com, linux-kernel@vger.kernel.org, dev@sw.ru,
       herbert@13thfloor.at, devel@openvz.org, ebiederm@xmission.com,
       xemul@sw.ru, haveblue@us.ibm.com, clg@fr.ibm.com
Subject: Re: [PATCH 0/9] namespaces: Introduction
Message-Id: <20060518212417.e255349c.pj@sgi.com>
In-Reply-To: <446D0333.1020503@vilain.net>
References: <20060518154700.GA28344@sergelap.austin.ibm.com>
	<20060518103430.080e3523.akpm@osdl.org>
	<446D0333.1020503@vilain.net>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can anyone see any that are missed?

I have no idea if this fits, as I am no virtual kernel wizard,
but how about various NUMA stuff, such as what CPUs and Memory
Nodes are online, and the three ways of controlling task and
memory placement on them:
  sched_setaffinity/sched_getaffinity
  set_mempolicy/get_mempolicy/mbind
  /dev/cpuset

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
