Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266798AbTGKVCa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 17:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266799AbTGKVCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 17:02:30 -0400
Received: from ore.jhcloos.com ([64.240.156.239]:24836 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S266798AbTGKVCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 17:02:24 -0400
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
References: <20030711140219.GB16433@suse.de>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <20030711140219.GB16433@suse.de>
Date: 11 Jul 2003 17:16:52 -0400
Message-ID: <m3r84wn4qj.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First it has:

|>IO subsystem.
|>~~~~~~~~~~~~~
|>- Several different IO elevators are available to match different types
|>  of workload.  You can select which one to use with elvtune.
                                                       ^^^^^^^
and then:

|>Deprecated.
|>~~~~~~~~~~~
|>- elvtune is deprecated (as are the ioctl's it used).
    ^^^^^^^^^^^^^^^^^^^^^
|>  Instead, the io scheduler tunables are exported in sysfs (see below)
|>  in the /sys/block/<device>/iosched directory.
|>  Jens wrote a document explaining the tunables of the new scheduler at
|>  http://www.lib.uaa.alaska.edu/linux-kernel/archive/2002-Week-44/att-deadline-iosched.txt

Also, it is /sys/block/<device>/queue/iosched/ on my box.
                                
-JimC

