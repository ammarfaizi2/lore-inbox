Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269616AbTGJVzL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 17:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266500AbTGJVyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 17:54:50 -0400
Received: from air-2.osdl.org ([65.172.181.6]:16366 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266499AbTGJVwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 17:52:18 -0400
Subject: Re: Hang with anticipatory I/O scheduler and aacraid controller
From: Mark Haverkamp <markh@osdl.org>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
In-Reply-To: <1057868803.19383.159.camel@markh1.pdx.osdl.net>
References: <1057868803.19383.159.camel@markh1.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1057874818.935.12.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 10 Jul 2003 15:06:58 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-10 at 13:26, Mark Haverkamp wrote:
> I have been seeing hangs when using an aacraid adapter after updating my
> kernel view to the latest as of yesterday.  It doesn't seem to affect
> the sym53c8xx that I have as the boot controller. I discovered today
> that if I boot with elevator=deadline that I don't see the hangs
> anymore.  I have been using dd to copy from one partition to another to
> create these hangs. 
> 
> It seems to be related to writes.  If I dd from a partition to /dev/null
> I don't see a hang.  But a dd from /dev/zero to a partition does hang.
> 

Sorry, this looks like a false alarm.  I updated my view to 2.5.75 this
afternoon and the problem seems to have disappeared.

Mark.

-- 
Mark Haverkamp <markh@osdl.org>

