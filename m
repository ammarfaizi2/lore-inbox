Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265543AbTAOAwa>; Tue, 14 Jan 2003 19:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265567AbTAOAwa>; Tue, 14 Jan 2003 19:52:30 -0500
Received: from coral.ocn.ne.jp ([211.6.83.180]:12498 "HELO
	smtp.coral.ocn.ne.jp") by vger.kernel.org with SMTP
	id <S265543AbTAOAw3>; Tue, 14 Jan 2003 19:52:29 -0500
Date: Wed, 15 Jan 2003 10:01:19 +0900
From: Bruce Harada <bharada@coral.ocn.ne.jp>
To: rusty@linux.co.intel.com
Cc: rusty@penguin.co.intel.com, linux-kernel@vger.kernel.org
Subject: Re: Unable to boot off kernel built on different machine
Message-Id: <20030115100119.6e8e731f.bharada@coral.ocn.ne.jp>
In-Reply-To: <200301141938.h0EJcaO8018734@penguin.co.intel.com>
References: <200301141938.h0EJcaO8018734@penguin.co.intel.com>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2003 11:38:36 -0800
Rusty Lynch <rusty@penguin.co.intel.com> wrote:

> I am having the strange problem (that I suspect is embarrassingly simple)
> where I can only boot a kernel built on the same machine.  For example
> my setup looks like:
> 
> * machine 'A' (RH 8.0 P4 system): 
>   - contains a 2.5 kernel tree on an exported NFS drive
>   - this is the machine where I do all my real work, and
>     do not want to run test kernels on
> * machine 'B' (RH 8.0 P3 system):
>   - mounts the kernel tree on 'A' to make it easy to
>     install new kernels on for testing
[SNIP]

Check /etc/fstab on machines A and B - what do they contain?

