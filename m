Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbVJZDMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbVJZDMV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 23:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbVJZDMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 23:12:21 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:35788 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932525AbVJZDMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 23:12:20 -0400
Subject: Re: (was: Oops in do_page_fault) ReiserFS problems... (Now with
	full trace)
From: Lee Revell <rlrevell@joe-job.com>
To: Chase Venters <chase.venters@clientec.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200510252136.14096.chase.venters@clientec.com>
References: <60411.67.163.102.102.1130266824.squirrel@webmail2.pair.com>
	 <1130270350.28314.72.camel@mindpipe>
	 <200510252136.14096.chase.venters@clientec.com>
Content-Type: text/plain
Date: Tue, 25 Oct 2005 23:11:15 -0400
Message-Id: <1130296276.4483.61.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-25 at 21:35 -0500, Chase Venters wrote:
> #1 - I've never seen any of the disks in this raid10 (md1 mounted
> on /) produce any CRC errors (though correct me if I'm wrong, I don't
> see any reason the kernel should BUG()/oops/panic because of corrupted
> filesystems) 

Reiser3 is notoriously bad at handling error conditions like this.  I
personally stopped using reiser3 when I had a power loss that caused
chunks of files to end up in other files.  I was able to fix the
critical ones with a text editor but who knows what other damage it did.

Lee

