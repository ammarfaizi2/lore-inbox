Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVC0Gwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVC0Gwj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 01:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVC0Gwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 01:52:39 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:50880 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261299AbVC0Gwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 01:52:37 -0500
Date: Sat, 26 Mar 2005 22:52:15 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: trivial@rustcorp.com.au
Cc: Simon Derr <Simon.Derr@bull.net>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Message-Id: <20050327065213.25762.54635.sendpatchset@sam.engr.sgi.com>
Subject: [Trivial Patch] cpusets docs - mention notify_on_release
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Provide (minimal) documentation of the cpusets notify_on_release file.

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.12-pj/Documentation/cpusets.txt
===================================================================
--- 2.6.12-pj.orig/Documentation/cpusets.txt	2005-03-26 19:57:27.000000000 -0800
+++ 2.6.12-pj/Documentation/cpusets.txt	2005-03-26 19:58:43.000000000 -0800
@@ -166,6 +166,7 @@ containing the following files describin
  - mems: list of Memory Nodes in that cpuset
  - cpu_exclusive flag: is cpu placement exclusive?
  - mem_exclusive flag: is memory placement exclusive?
+ - notify_on_release: call /sbin/cpuset_release_agent on exit if set
  - tasks: list of tasks (by pid) attached to that cpuset
 
 New cpusets are created using the mkdir system call or shell
@@ -333,7 +334,7 @@ Now you want to do something with this c
 
 In this directory you can find several files:
 # ls
-cpus  cpu_exclusive  mems  mem_exclusive  tasks
+cpus  cpu_exclusive  mems  mem_exclusive  notify_on_release  tasks
 
 Reading them will give you information about the state of this cpuset:
 the CPUs and Memory Nodes it can use, the processes that are using

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
