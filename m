Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbUDMILu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 04:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263211AbUDMILu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 04:11:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:10418 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262984AbUDMILt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 04:11:49 -0400
Date: Tue, 13 Apr 2004 01:11:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mm5 devpts filesystem doesn't work
Message-Id: <20040413011133.2d15a4d6.akpm@osdl.org>
In-Reply-To: <407B9FB1.8070107@aitel.hist.no>
References: <20040412221717.782a4b97.akpm@osdl.org>
	<407B9FB1.8070107@aitel.hist.no>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helgehaf@aitel.hist.no> wrote:
>
> I tried stepping up from 2.6.5-rc3-mm4 to 2.6.5-mm4.
> This Quokka seems too zonked to work though.
> 
> It came up, but I couldn't run "xterm".  Trying from
> the xemacs shell I saw an error message about not enough ptys.
> I use the devpts fs mounted on /dev/pts
> 
> It mounts just fine, but doesn't work apparently.  There are no
> such problems with 2.6.5-rc3-mm4

Is this 2.6.5-mm4 or 2.6.5-mm5?

If the latter, try reverting pty-allocation-first-fit.patch
