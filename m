Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262690AbVCWB3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbVCWB3u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 20:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbVCWB3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 20:29:50 -0500
Received: from fire.osdl.org ([65.172.181.4]:5292 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262690AbVCWB3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 20:29:44 -0500
Date: Tue, 22 Mar 2005 17:29:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: rlrevell@joe-job.com, diegocg@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: dmesg verbosity [was Re: AGP bogosities]
Message-Id: <20050322172909.2fa077e1.akpm@osdl.org>
In-Reply-To: <20050323011313.GL15879@redhat.com>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.62.0503140026360.10211@qynat.qvtvafvgr.pbz>
	<20050314083717.GA19337@elf.ucw.cz>
	<200503140855.18446.jbarnes@engr.sgi.com>
	<20050314191230.3eb09c37.diegocg@gmail.com>
	<1110827273.14842.3.camel@mindpipe>
	<20050323013729.0f5cd319.diegocg@gmail.com>
	<1111539217.4691.57.camel@mindpipe>
	<20050323011313.GL15879@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
>  This old mail: http://marc.free.net.ph/message/20040304.030616.59761bf3.html
>  references a 'move block' ioctl, which is probably the hardest part of the problem,
>  though I didn't find the code referenced in that mail. Andrew ?

That would be http://www.zip.com.au/~akpm/ext3-reloc-page.patch

Against 2.4.18, untested ;)

>  With something like this, and some additional bookkeeping to keep track of
>  which files we open in the first few minutes of uptime, we could periodically
>  reorganise the layout back to an optimal state.

Fun project.
