Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263535AbUDBBm2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 20:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbUDBBm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 20:42:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:53136 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263535AbUDBBmY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 20:42:24 -0500
Date: Thu, 1 Apr 2004 17:44:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Olof Johansson <olof@austin.ibm.com>
Cc: manfred@colorfullife.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       anton@samba.org
Subject: Re: Oops in get_boot_pages at reboot
Message-Id: <20040401174426.608fb4cb.akpm@osdl.org>
In-Reply-To: <Pine.A41.4.44.0404011847370.26954-100000@forte.austin.ibm.com>
References: <20040401105553.38468a64.akpm@osdl.org>
	<Pine.A41.4.44.0404011847370.26954-100000@forte.austin.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olof Johansson <olof@austin.ibm.com> wrote:
>
> Well, how about making system_running a state instead of a flag, and
> defining states SYSTEM_BOOTING/RUNNING/SHUTDOWN?

Eminently sane, of course.  I'll rename it to system_state, to reflect the
new reality and to catch unconverted users.

