Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317746AbSFSCbm>; Tue, 18 Jun 2002 22:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317747AbSFSCbl>; Tue, 18 Jun 2002 22:31:41 -0400
Received: from omniver.ne.client2.attbi.com ([66.30.197.22]:23791 "HELO
	carboy.peaveynet.com") by vger.kernel.org with SMTP
	id <S317746AbSFSCbl>; Tue, 18 Jun 2002 22:31:41 -0400
Date: Tue, 18 Jun 2002 22:29:14 -0400
From: "Justin S. Peavey" <jpeavey+kernel@peaveynet.com>
To: Rui Sousa <rui.sousa@laposte.net>
Cc: linux-kernel@vger.kernel.org,
       emu10k1-devel <emu10k1-devel@lists.sourceforge.net>
Subject: Re: Oops from EMU10K1 (2.4.18 and CVS version)
Message-ID: <20020619022914.GE15266@colltech.com>
Mail-Followup-To: Rui Sousa <rui.sousa@laposte.net>,
	linux-kernel@vger.kernel.org,
	emu10k1-devel <emu10k1-devel@lists.sourceforge.net>
References: <20020616201656.GE15266@colltech.com> <Pine.LNX.4.44.0206180120580.2633-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0206180120580.2633-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-6mdk on an i686
X-PGP-Key: http://www.peaveynet.com/~jpeavey/gpg.key
X-PGP-Fingerprint: 9D65 5346 78FA 5186 896D  B35A D97A 370B 1F8C 2F6F
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was indeed the problem, a full kernel build with 2.4.19-pre10
fixed the issue.  

Many thanks,
-Justin

On Tue, Jun 18, 2002 at 01:30:31AM +0200, Rui Sousa scribed to Cc linux-kernel@vger.kernel.org:
> 
> Can you try and install 2.4.19-pre10 with the included emu10k1?
> I suspect you are just hitting a driver miscompilation problem when
> compiling the module outside the kernel tree (somehow not using the 
> correct compile options...) since the crash is inside 
> interrupt_sleep_on().
> 
> Rui Sousa
