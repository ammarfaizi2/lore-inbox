Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264097AbUHMIx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbUHMIx5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 04:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269038AbUHMIx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 04:53:57 -0400
Received: from mailhost.cs.auc.dk ([130.225.194.6]:11667 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP id S264097AbUHMIx4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 04:53:56 -0400
Subject: Re: Accessing Inodes??
From: Emmanuel Fleury <fleury@cs.auc.dk>
To: linux-kernel@vger.kernel.org
Cc: Harish K Harshan <harish@amritapuri.amrita.edu>
In-Reply-To: <50737.203.197.150.195.1092384713.squirrel@203.197.150.195>
References: <50737.203.197.150.195.1092384713.squirrel@203.197.150.195>
Content-Type: text/plain
Organization: Aalborg University -- Computer Science Dept.
Message-Id: <1092387123.16274.35.camel@rade7.e.cs.auc.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 13 Aug 2004 10:52:03 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-13 at 10:11, Harish K Harshan wrote:
> I am doing a project on implementing mandatory access control in the linux
> kernel. I would like to know how to acces or modify the inodes of files
> and directories on a hard disk. Please help me.

You should use the LSM hooks for this.

See: 
http://www.nsa.gov/selinux/papers/module/t1.html
http://umbrella.sourceforge.net/
...
And a lot of others
...

Regards
-- 
Emmanuel Fleury

Computer Science Department, |  Office: B1-201
Aalborg University,          |  Phone:  +45 96 35 72 23
Fredriks Bajersvej 7E,       |  Fax:    +45 98 15 98 89
9220 Aalborg East, Denmark   |  Email:  fleury@cs.auc.dk

