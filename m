Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422648AbVKZHm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422648AbVKZHm3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 02:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932726AbVKZHm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 02:42:29 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:8440 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932205AbVKZHm2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 02:42:28 -0500
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2F3CDB0C-5E50-11DA-8242-000A959BB91E@mvista.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: david singleton <dsingleton@mvista.com>
Subject: robust futex heap support patch
Date: Fri, 25 Nov 2005 23:42:24 -0800
To: robustmutexes@lists.osdl.org, Ingo Molnar <mingo@elte.hu>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a new patch, patch-2.6.14-rt15-rf1,  that adds support for 
robust and priority inheriting
pthread_mutexes on the 'heap'.

The previous patches only supported either file based pthread_mutexes 
or mmapped anonymous memory based pthread_mutexes.  This patch allows 
pthread_mutexes
to be 'malloc'ed while using the PTHREAD_MUTEX_ROBUST_NP attribute
or PTHREAD_PRIO_INHERIT attribute.

The patch can be found at:

http://source.mvista.com/~dsingleton

David

