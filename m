Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293544AbSCSCis>; Mon, 18 Mar 2002 21:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293546AbSCSCii>; Mon, 18 Mar 2002 21:38:38 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:23540
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S293544AbSCSCiW>; Mon, 18 Mar 2002 21:38:22 -0500
Date: Mon, 18 Mar 2002 18:39:39 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
Cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: Looking to do userless input 'make *config' .
Message-ID: <20020319023939.GL2254@matchmail.com>
Mail-Followup-To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>,
	Linux Kernel Maillist <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0203182055340.275-100000@filesrv1.baby-dragons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2002 at 09:26:00PM -0500, Mr. James W. Laferriere wrote:
> 
> 	Hello All ,  I have a .config file that has only the needed items
> 	defined .  What I am looking to do is have the 'make *config'
> 	be in a script that builds a kernel .  I'd like to have all
> 	entries that would pop up in a 'make oldconfig' as undefined
> 	be defined as 'N' .  I am not looking for this to cross major
> 	kernel versions (ie: 2.4 -> 2.5) just to many possible changes in
> 	the code .  Does anyone have any pointers ?  Tia ,  JimL

It's not automatic, but oldconfig defaults to "N" so 'make oldconfig' and
hold down <ENTER>...

This is a one time thing (2.4 -> 2.5) so why write a script for it?

Does anyone have any reasons why James couldn't just start compiling with a
previous .config?  

hmm, maybe I should check the FAQ...

... nope, only one occourance of "oldconfig" and that didn't help...

