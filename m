Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbUEGD7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbUEGD7L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 23:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbUEGD7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 23:59:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:20137 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262547AbUEGD7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 23:59:10 -0400
Date: Thu, 6 May 2004 20:58:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Jakma <paul@clubi.ie>
Cc: arjanv@redhat.com, Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
Message-Id: <20040506205838.6948a018.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405070433170.1979@fogarty.jakma.org>
References: <20040505013135.7689e38d.akpm@osdl.org>
	<200405051312.30626.dominik.karall@gmx.net>
	<200405051822.i45IM2uT018573@turing-police.cc.vt.edu>
	<20040505215136.GA8070@wohnheim.fh-wedel.de>
	<200405061518.i46FIAY2016476@turing-police.cc.vt.edu>
	<1083858033.3844.6.camel@laptop.fenrus.com>
	<Pine.LNX.4.58.0405070136010.1979@fogarty.jakma.org>
	<20040506195002.520b0793.akpm@osdl.org>
	<Pine.LNX.4.58.0405070433170.1979@fogarty.jakma.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jakma <paul@clubi.ie> wrote:
>
> Fair enough but have a look at the other fault from that bug though:
> 
>  	https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=99855&action=view 
> 
>  That one did not recurse for some reason.

OK.

So we're 50 to 60 levels deep in function calls there and simply ran out
of 4k stack.

Based on this and upon the few other feedbackings I've had on this issue it
seems that the 4k stack experiment will come back saying "no".

Thanks.
