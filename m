Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271194AbTHCOQg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 10:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271195AbTHCOQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 10:16:36 -0400
Received: from ns.suse.de ([213.95.15.193]:49930 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S271194AbTHCOQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 10:16:35 -0400
To: carl wolff <testkernel@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Testing 2.6 kernel
References: <20030803135745.64460.qmail@web20705.mail.yahoo.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 03 Aug 2003 16:16:33 +0200
In-Reply-To: <20030803135745.64460.qmail@web20705.mail.yahoo.com.suse.lists.linux.kernel>
Message-ID: <p73r842omgu.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

carl wolff <testkernel@yahoo.com> writes:

> Hello
> 
> I've machinetime and machine (dell 530 Dual Xeon 1.4
> Ghz, 1GB) available to do automated kernel testing
> (2.6) based on LTP.
> 
> Can anyone give answer to the following questions:
> 1) Is this helpful?

There are already various people testing LTP. It would 
be better if you could test what you would normally do
(e.g. data base loads or whatever) because the "real world
coverage" is a bit more lacking.

> 2) Some small hints to get it very effective?

If you want to test LTP better concentrate less on
the standard functional runs, but more on the stress tests
to test your particular drivers etc. Often they have
to be invoked manually.

-Andi
