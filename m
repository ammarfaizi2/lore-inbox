Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbTJNJAR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 05:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbTJNJAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 05:00:17 -0400
Received: from web13008.mail.yahoo.com ([216.136.174.18]:7693 "HELO
	web13008.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262262AbTJNJAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 05:00:14 -0400
Message-ID: <20031014090008.94768.qmail@web13008.mail.yahoo.com>
Date: Tue, 14 Oct 2003 02:00:07 -0700 (PDT)
From: wessly x <wessly_x@yahoo.com>
Subject: how to detect the state change for all the processes?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How to write a module to detect the state change (from
sleeping to running state) for all the processes in my
Linux system. Anyone know how to do that? A process
state will change from sleeping to running state 
after a system call (wake_up_process()), is there a
way so that my module can catch this system call , so
that i can get the pid of the process which
experienced a state changed?

Due to the remove of sys_call__table[], so i need
other way to doit...... pls comment


__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
