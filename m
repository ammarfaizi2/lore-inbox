Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269280AbUJWDXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269280AbUJWDXH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 23:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269297AbUJWDS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 23:18:58 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:52185 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269324AbUJWDQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 23:16:51 -0400
Subject: mozilla-mail damage [was Re: [PATCH] Update to
	Documentation/ramdisk.txt - take 2]
From: Lee Revell <rlrevell@joe-job.com>
To: Kurt Wall <kwall@kurtwerks.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1098498910.9092.8.camel@krustophenia.net>
References: <4179B7A9.6020205@verizon.net>
	 <20041023021227.GF4368@kurtwerks.com>
	 <1098498910.9092.8.camel@krustophenia.net>
Content-Type: text/plain
Date: Fri, 22 Oct 2004 23:16:49 -0400
Message-Id: <1098501410.9092.36.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-22 at 22:35 -0400, Lee Revell wrote:
> On Fri, 2004-10-22 at 22:12 -0400, Kurt Wall wrote:
> > On Fri, Oct 22, 2004 at 09:45:13PM -0400, Jim Nelson took 229 lines to write:
> > > @#%*^#$ Mozilla.  Line wrap was set too low.
> > > 
> > > Let's try this again - hopefully, Mozilla won't mangle my patch this time.
> > 
> > Urgl:
> > 
> > patching file Documentation/ramdisk.txt
> > Hunk #1 FAILED at 5.
> 
> You cannot just increase the line wrap and hope Mozilla will do the
> right thing.  Mozilla should have an option to insert preformatted text.

OK I just went and installed mozilla mail to see what the problem is and
it's worse than I thought.

The problem is that Mozilla does not grok the standard X clipboard at
all.

Try these tests:

1. Highlight some text in an xterm.  Paste with middle button into
Mozlla  mail window.  Then paste with the middle button into vim.  Both
work BUT the patch is whitespace damaged.

2. Run diff foo bar | xclip.  Paste with middle button into Mozilla.
Nothing.  Then paste with middle button into vim.  Works.

#2 would not mangle the patch IF it worked which it doesn't.  Mozilla
does not have a setting to insert a text file.  So many people just do
#1.

No wonder people are mangling patches, the Mozilla mail client is very
broken.  PLEASE, file bug reports!

Lee


	

