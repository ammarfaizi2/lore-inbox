Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263066AbTDFT7B (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 15:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263067AbTDFT7B (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 15:59:01 -0400
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:19662 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S263066AbTDFT7A (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 15:59:00 -0400
Date: Sun, 6 Apr 2003 21:08:00 +0100
From: Malcolm Beattie <mbeattie@clueful.co.uk>
To: oliver@neukum.name
Cc: Dan Kegel <dank@kegel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH] new syscall: flink
Message-ID: <20030406210800.A5450@clueful.co.uk>
References: <3E907A94.9000305@kegel.com> <200304062156.37325.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200304062156.37325.oliver@neukum.org>; from oliver@neukum.org on Sun, Apr 06, 2003 at 09:56:37PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum writes:
> If you have an fd, the permissions based on the path are already
> bypassed, whether you can call flink or not, aren't they?

Not if it's opened O_RDONLY, for example.

--Malcolm

-- 
Malcolm Beattie <mbeattie@clueful.co.uk>
