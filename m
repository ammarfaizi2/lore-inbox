Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264834AbUE0RyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264834AbUE0RyN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 13:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264902AbUE0RyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 13:54:13 -0400
Received: from lug.demon.co.uk ([80.177.165.112]:7479 "EHLO lug.demon.co.uk")
	by vger.kernel.org with ESMTP id S264834AbUE0RyL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 13:54:11 -0400
From: David Johnson <dj@david-web.co.uk>
Reply-To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject: Re: Can't make XFS work with 2.6.6
Date: Thu, 27 May 2004 18:54:20 +0100
User-Agent: KMail/1.6
References: <200405271736.08288.dj@david-web.co.uk> <1085676905.5311.33.camel@buffy>
In-Reply-To: <1085676905.5311.33.camel@buffy>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405271854.20787.dj@david-web.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 May 2004 17:55, David Aubin wrote:
> Your ide support is compiled as a module.  If you are not calling out
> the module
> in your initrc, then you will get this.  Go back and compile in your ide
> support
> or scsi support as compiled in options.  Both are currently built as
> modules.
>

OK, I recompiled with the IDE compiled in, but it didn't make much 
difference :-(
The error is the same except for: -

Instead of:
Kernel Panic: VFS: Unable to mount root fs on unknown-block(0,0)

I get:
Kernel Panic: VFS: Unable to mount root fs on hda3

Thanks for your help so far,
David.

-- 
David Johnson
http://www.david-web.co.uk/
