Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265764AbUA0Vbm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 16:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265772AbUA0Vbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 16:31:42 -0500
Received: from server19.glai.de ([80.239.154.135]:28053 "EHLO server19.glai.de")
	by vger.kernel.org with ESMTP id S265764AbUA0Vbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 16:31:34 -0500
Date: Tue, 27 Jan 2004 22:30:26 +0100
From: markus reichelt <mr@lists.notified.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1 "clock preempt"?
Message-ID: <20040127213026.GA1315@lists.notified.de>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
References: <1074800554.21658.68.camel@cog.beaverton.ibm.com> <20040122195026.GA579@h00a0cca1a6cf.ne.client2.attbi.com> <1074801242.21658.71.camel@cog.beaverton.ibm.com> <20040122200044.GA593@h00a0cca1a6cf.ne.client2.attbi.com> <1074806504.21658.76.camel@cog.beaverton.ibm.com> <20040123190205.GA477@h00a0cca1a6cf.ne.client2.attbi.com> <1074885449.12446.27.camel@localhost> <20040123193635.GA492@h00a0cca1a6cf.ne.client2.attbi.com> <1074888405.12447.41.camel@localhost> <20040123203835.GA518@h00a0cca1a6cf.ne.client2.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
In-Reply-To: <20040123203835.GA518@h00a0cca1a6cf.ne.client2.attbi.com>
Organization: still stuck in reorganization mode
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

timothy parkinson <t@timothyparkinson.com> wrote:
> * Running with SpeedStep (this is a cpu thing i assume?) could cause this.
> * Not having DMA enabled on your hard disk(s) could cause this.  See the hdparm
>   utility to enable it.
> * Incorrect TSC synchronization on SMP systems could cause this.
> * Anything else?

Yepp:

Jan 27 20:12:12 tatooine kernel: Losing too many ticks!

I had to set "CONFIG_IDE_TASK_IOCTL=y" in my .config in order to get
it working.

- -- 
Bastard Administrator in $hell
GPG-Key at http://lists.notified.de/

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAFthyLMyTO8Kj/uQRAojoAJ9ZIdhKEij8DW/QdkO1ZG9ksi1hqwCeMGQA
jjROcxpIDSJgirm931LKl0c=
=v37i
-----END PGP SIGNATURE-----
