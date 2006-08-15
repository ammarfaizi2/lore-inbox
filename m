Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030453AbWHOScg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030453AbWHOScg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030450AbWHOScf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:32:35 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:7561 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030453AbWHOSce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:32:34 -0400
Subject: Re: [PATCH 6/7] vt: Update spawnpid to be a struct pid_t
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       containers@lists.osdl.org, Oleg Nesterov <oleg@tv-sign.ru>
In-Reply-To: <1155666193191-git-send-email-ebiederm@xmission.com>
References: <m1k65997xk.fsf@ebiederm.dsl.xmission.com>
	 <1155666193191-git-send-email-ebiederm@xmission.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 15 Aug 2006 19:53:02 +0100
Message-Id: <1155667982.24077.307.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-15 am 12:23 -0600, ysgrifennodd Eric W. Biederman:
> This keeps the wrong process from being notified if the
> daemon to spawn a new console dies.

Not sure why we count pids not task structs but within the proposed
implementation this appears correct so

Acked-by: Alan Cox <alan@redhat.com>

