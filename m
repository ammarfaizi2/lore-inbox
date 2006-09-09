Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbWIIWSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWIIWSz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 18:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbWIIWSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 18:18:55 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:9172 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S964873AbWIIWSy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 18:18:54 -0400
Date: Sun, 10 Sep 2006 02:18:39 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Jean Delvare <jdelvare@suse.de>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] proc: bye bye tasklist_lock
Message-ID: <20060909221839.GA141@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fs/proc/ does not use tasklist_lock anymore.

These patches are simple enough and do not depend on each other.
The only problem I don't know how to really test them.

Can anybody recommend a stress-test?

Oleg.

