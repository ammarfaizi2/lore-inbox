Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269030AbUIMW71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269030AbUIMW71 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 18:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269034AbUIMW5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 18:57:20 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:45511 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269030AbUIMW4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 18:56:52 -0400
Date: Mon, 13 Sep 2004 15:56:29 -0700
From: Paul Jackson <pj@sgi.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm5 scheduling while atomic
Message-Id: <20040913155629.61c8fd85.pj@sgi.com>
In-Reply-To: <200409131447.41607.jbarnes@engr.sgi.com>
References: <20040913015003.5406abae.akpm@osdl.org>
	<200409131447.41607.jbarnes@engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The messages began right after I logged out of an ssh session and haven't 

I got the same messages, on another Altix sn2_defconfig, after I had:

 1) logged in as the only, root user,
 2) played around a bit, then
 3) issued a 'reboot' command.

Then bamo - lots of scheduling while atomic! complaints.  Though the
shutdown did succeed, and shut the complaints off.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
