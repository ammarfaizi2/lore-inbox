Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314472AbSDFNvM>; Sat, 6 Apr 2002 08:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314473AbSDFNvL>; Sat, 6 Apr 2002 08:51:11 -0500
Received: from [216.167.37.170] ([216.167.37.170]:21764 "EHLO cob427.dn.net")
	by vger.kernel.org with ESMTP id <S314472AbSDFNvK>;
	Sat, 6 Apr 2002 08:51:10 -0500
Date: Sat, 6 Apr 2002 19:21:13 +0530
From: "Sapan J . Bhatia" <lists@corewars.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] POLL_OUT in ttys, misc bug fix
Message-ID: <20020406192113.A2649@corewars.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux corewars 2.4.18
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Marcelo!

Yes, I have been testing them with userspace applications (most notably 
User Mode Linux).

The following program's output gets truncated on a pty running on a normal
kernel, but works fine when the patch is applied:
   www.corewars.org/pollout.c

Also, the version I'd sent you earlier did not have a fix for serial.c, which
exhibits the same problems. I've posted another version earlier today which 
includes this as well as a minor change to the second bug fix.
Please use the new version instead of the earlier one.

      Cheers,
    Sapan


On Thu, Apr 04, 2002 at 04:56:22PM -0300, Marcelo Tosatti wrote:
// 
// Sapan, 
// 
// Have you actually tested the SIGIO POLL_OUT changes with an userspace app?
// 
// Thanks
// 

