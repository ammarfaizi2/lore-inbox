Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311271AbSCTB4F>; Tue, 19 Mar 2002 20:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311270AbSCTBz4>; Tue, 19 Mar 2002 20:55:56 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:63736
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S311485AbSCTBzh>; Tue, 19 Mar 2002 20:55:37 -0500
Date: Tue, 19 Mar 2002 17:57:00 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Ed Vance <EdV@macrolink.com>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: FW: Intel PII machine hangs with MCE enabled in linux-2.4.19-pre3
Message-ID: <20020320015700.GA7708@matchmail.com>
Mail-Followup-To: Ed Vance <EdV@macrolink.com>,
	'linux-kernel' <linux-kernel@vger.kernel.org>
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A771C@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 05:49:39PM -0800, Ed Vance wrote:
> On Mon Mar 18, 2002 at 12:20 PM, Dual Mobius wrote:
> > 
> > Intel PII machine hangs with MCE enabled in
> > linux-2.4.19-pre3
> > 
> > Under linux 2.4.19-pre3, my Intel Pentium II system
> > hangs with the "machine check" turned on
> > (CONFIG_X86_MCE=y).  The same machine booted correctly
> > under 2.4.19-pre2 with MCE enabled.
> > 
> > I get the following output from the kernel when
> > booting, and then it freezes:
> > 
> > [snip]
> > 
> > Intel machine check architecture supported.
> >
> 
> Me too.
> 
> Pentium II mobile module in Motorola CPV5350, 2.4.19-pre3 kernel.
> Hangs after boot message "Intel machine check architecture supported".
> Turning off CONFIG-X86_MCE did not help in my case, but I didn't do a make
> mrproper before recompiling the kernel ... so I suppose I don't really know
> that for sure yet.
> 

Back out the changes in bluesmoke.c and you're set.  Your should've read the
archive because this issue has been reported many times...
