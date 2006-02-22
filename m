Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbWBVXGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbWBVXGx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 18:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbWBVXGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 18:06:53 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:33256 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751457AbWBVXGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 18:06:53 -0500
Message-ID: <43FCEDDA.8A7DB8F6@tv-sign.ru>
Date: Thu, 23 Feb 2006 02:03:54 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       David Howells <dhowells@redhat.com>
Subject: [PATCH 0/6] some tasklist_lock removals
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Depends on "[PATCH 0/3] make threads traversal ->siglock safe".

These patches are unordered, each of them could be applied/reverted
independently. Hopefully not every patch adds a bug.

Oleg.
