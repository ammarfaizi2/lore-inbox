Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbUCZGxL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 01:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbUCZGxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 01:53:11 -0500
Received: from fe6-cox.cox-internet.com ([66.76.2.51]:42638 "EHLO
	fe6.cox-internet.com") by vger.kernel.org with ESMTP
	id S261321AbUCZGxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 01:53:09 -0500
Message-ID: <4063D30C.30305@cox-internet.com>
Date: Fri, 26 Mar 2004 00:51:56 -0600
From: billy rose <billyrose@cox-internet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: arch 386
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i sent an email last night, but i think my email host was down so i will 
try again. since 2.6.x can preempt, what do you think about using a call 
gate in place of int 80? sysenter was implemented in this fashion for 
p4's, but there are a lot of pre p4 boxes still out there. operations 
that will not allow for a conforming code segment could simply turn 
around and issue the int 80, or use a task gate.

=====
Billy

"There's some milk in the fridge that's about to go bad...
     And there is goes..." --Bobby


