Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263506AbTJQTZt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 15:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263587AbTJQTZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 15:25:49 -0400
Received: from axion.demon.nl ([195.173.231.39]:35201 "EHLO axion.demon.nl")
	by vger.kernel.org with ESMTP id S263506AbTJQTZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 15:25:44 -0400
Date: Fri, 17 Oct 2003 21:25:37 +0200
From: Monchi Abbad <kernel@axion.demon.nl>
To: linux-kernel@vger.kernel.org
Cc: mvw@planets.elm.net
Subject: Quota (v1 ?) problems when creating a new user.
Message-ID: <20031017192537.GB1651@axion.demon.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description:
When using quota and creating a new user on the system quota and limit get extreme high values.
The system is a slackware 9.1 customized system.

Keywords:
quota ext3

Kernel version:
Linux version 2.6.0-test7 (root@axion) (gcc version 3.2.3) #1 Thu Oct 9 11:16:09 CEST 2003

Output of error.
root@axion:/usr/src/linux# useradd test5
root@axion:/usr/src/linux# quota -v test5
Disk quotas for user test5 (uid 10126):
     Filesystem  blocks   quota   limit   grace   files   quota   limit   grace
      /dev/sdd2       5  3755993804 3755993796               2       0       0
root@axion:/usr/src/linux#

Monchi.
--

