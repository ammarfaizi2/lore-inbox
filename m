Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265640AbTIJTUR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 15:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265613AbTIJTS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 15:18:56 -0400
Received: from CPE-65-29-19-166.mn.rr.com ([65.29.19.166]:1939 "EHLO
	www.enodev.com") by vger.kernel.org with ESMTP id S265625AbTIJTRw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 15:17:52 -0400
Subject: Re: Efficient IPC mechanism on Linux
From: Shawn <core@enodev.com>
To: Luca Veraldi <luca.veraldi@katamail.com>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <01f801c37783$9ead8960$5aaf7450@wssupremo>
References: <00f201c376f8$231d5e00$beae7450@wssupremo>
	 <20030909175821.GL16080@Synopsys.COM>
	 <001d01c37703$8edc10e0$36af7450@wssupremo>
	 <20030910064508.GA25795@Synopsys.COM>
	 <015601c3777c$8c63b2e0$5aaf7450@wssupremo>
	 <1063185795.5021.4.camel@laptop.fenrus.com>
	 <01c601c3777f$97c92680$5aaf7450@wssupremo>
	 <20030910114414.B14352@devserv.devel.redhat.com>
	 <01f801c37783$9ead8960$5aaf7450@wssupremo>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063221378.24353.11.camel@www.enodev.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 10 Sep 2003 14:16:18 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-10 at 05:09, Luca Veraldi wrote:
> > For fun do the measurement on a pIV cpu. You'll be surprised.
> > The microcode "mark dirty" (which is NOT a btsl, it gets done when you do
> a write
> > memory access to the page content) result will be in the 2000 to 4000
> range I
> > predict.
> 
> I'm not responsible for microarchitecture designer stupidity.
> If a simple STORE assembler instruction will eat up 4000 clock cycles,
> as you say here, well, I think all we Computer Scientists can go home and
> give it up now.
Unfortunately you are responsible for working with the constructs reality
has given you. Giving up is childish. Where there is a lose, there's a
chance it was a tradeoff for a win elsewhere.

