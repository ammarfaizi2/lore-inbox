Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbUCXKFp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 05:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263192AbUCXKFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 05:05:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:3983 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263126AbUCXKFo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 05:05:44 -0500
Date: Wed, 24 Mar 2004 02:05:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Zwickel <martin.zwickel@technotrend.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm2
Message-Id: <20040324020538.654905ee.akpm@osdl.org>
In-Reply-To: <20040324110014.4cdb7597@phoebee>
References: <20040323232511.1346842a.akpm@osdl.org>
	<20040324110014.4cdb7597@phoebee>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Zwickel <martin.zwickel@technotrend.de> wrote:
>
> Hi Andrew!
> 
> I'm unable to start my X server with this patch.
> I have the nvidia 5336 module loaded and if I start the X server, the machine
> completely freezes. With 2.6.5-rc2 everything works ok...

-mm kernels currently are using 4k kernel stacks.  The nvidia driver
doesn't have a hope of running in that environment.

