Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263358AbUDMIoR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 04:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263336AbUDMIlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 04:41:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:33218 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263361AbUDMIj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 04:39:59 -0400
Date: Tue, 13 Apr 2004 01:39:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: helgehaf@aitel.hist.no, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mm5 devpts filesystem doesn't work
Message-Id: <20040413013942.181cb2b5.akpm@osdl.org>
In-Reply-To: <20040413011133.2d15a4d6.akpm@osdl.org>
References: <20040412221717.782a4b97.akpm@osdl.org>
	<407B9FB1.8070107@aitel.hist.no>
	<20040413011133.2d15a4d6.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> > It mounts just fine, but doesn't work apparently.  There are no
>  > such problems with 2.6.5-rc3-mm4
> 
>  Is this 2.6.5-mm4 or 2.6.5-mm5?
> 
>  If the latter, try reverting pty-allocation-first-fit.patch

yes, that patch is bust.  And rwsem-scale.patch is oopsing all over the
place.  Ho hum.

I've trashed 2.6.5-mm5 and am uploading 2.6.5-mm5-1, same place.

