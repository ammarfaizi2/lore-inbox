Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265293AbTIJRN5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 13:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265295AbTIJRN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 13:13:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:3308 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265293AbTIJRNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 13:13:55 -0400
Date: Wed, 10 Sep 2003 09:55:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm5 SMP (and mm6 and plain test5) got stuck during
 boot
Message-Id: <20030910095559.249cdf68.akpm@osdl.org>
In-Reply-To: <3F5F24AB.7060304@aitel.hist.no>
References: <3F5847B7.9070308@aitel.hist.no>
	<3F5F24AB.7060304@aitel.hist.no>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helgehaf@aitel.hist.no> wrote:
>
> 2.6.0-test4-mm4, mm6 and plain 2.6.0-test5 are all useless on my
> dual celeron.  The machine get stuck when initscripts
> tries to configure networking.  I can break
> out of that with ctrl+c, but then it gets
> stuck on something else shortly thereafter,
> so I can't get as far as logging in.

Please try test5-mm1.  If it still gets stuck then use
sysrq-P and sysrq-T to work out where it is hanging.

