Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265560AbUFDCcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265560AbUFDCcm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 22:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265569AbUFDCcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 22:32:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:45994 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265560AbUFDCbt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 22:31:49 -0400
Date: Thu, 3 Jun 2004 19:31:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ed Tomlinson <edt@aei.ca>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: ide errors in 7-rc1-mm1 and later
Message-Id: <20040603193107.54308dc9.akpm@osdl.org>
In-Reply-To: <200406032207.25602.edt@aei.ca>
References: <1085689455.7831.8.camel@localhost>
	<200405271928.33451.edt@aei.ca>
	<200406032207.25602.edt@aei.ca>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson <edt@aei.ca> wrote:
>
> Hi,
> 
> I am still getting these ide errors with 7-rc2-mm2.  I  get the errors even
> if I mount with barrier=0 (or just defaults).  It would seem that something is 
> sending my drive commands it does not understand...  
> 
> May 27 18:18:05 bert kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> May 27 18:18:05 bert kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
> 
> How can we find out what is wrong?
> 
> This does not seem to be an error that corrupts the fs, it just slows things 
> down when it hits a group of these.  Note that they keep poping up - they
> do stop (I still get them hours after booting).

Jens, do we still have the command bytes available when this error hits?
