Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264031AbUDBMdW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 07:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264033AbUDBMdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 07:33:22 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:44553 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264031AbUDBMdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 07:33:21 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.5-rc3-mm2
Date: Fri, 2 Apr 2004 14:32:49 +0200
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20040331014351.1ec6f861.akpm@osdl.org> <200403311937.41510@WOLK> <20040402122759.GC4304@suse.de>
In-Reply-To: <20040402122759.GC4304@suse.de>
X-Operating-System: Linux 2.6.4-wolk2.3 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200404021432.49440@WOLK>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 April 2004 14:27, Jens Axboe wrote:

Hi Jens,

> > is there any reason why I see /sys/block/hda/queue/iosched/ beeing empty?
> > I thought every I/O scheduler would put in there some tunables or at
> > least some info's what defaults are used. Or did I miss something
> > completely and now I am totally wrong?

> This branch of CFQ doesn't implement the parameters as sysfs modifyable,
> later versions do.

Do you have any later versions of cfq? I had cfq-4 with ioprios in my tree but 
that version I have has fatal performance problems compared to the cfq-4 in 
-mm.

It's this one here: 
http://marc.theaimsgroup.com/?l=linux-kernel&m=106830068220545&w=2

ciao, Marc
