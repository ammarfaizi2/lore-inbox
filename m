Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264330AbUEXQE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264330AbUEXQE3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 12:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264331AbUEXQE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 12:04:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:149 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264330AbUEXQE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 12:04:27 -0400
Date: Mon, 24 May 2004 08:54:17 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Ed Tomlinson <edt@aei.ca>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, zwane@arm.linux.org.uk
Subject: Re: [PATCH][2.6-mm] Make i386 boot not so chatty
Message-Id: <20040524085417.169d660d.rddunlap@osdl.org>
In-Reply-To: <200405220801.53761.edt@aei.ca>
References: <Pine.LNX.4.58.0405210032160.2864@montezuma.fsmlabs.com>
	<20040520234006.291c3dfa.akpm@osdl.org>
	<200405220801.53761.edt@aei.ca>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 May 2004 08:01:53 -0400 Ed Tomlinson wrote:

| On May 21, 2004 02:40 am, Andrew Morton wrote:
| > Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
| > >
| > > This patch silences the default i386 boot by putting a lot of development
| > >  related printks under KERN_DEBUG loglevel, allowing the normal chatty mode
| > >  to be turned on by using the 'debug' kernel parameter.
| > 
| > I think I like it chatty.  Turning this stuff off by default makes kernel
| > developers' lives that little bit harder.
| > 
| > Is the `quiet' option not suitable?
| 
| I have been using linux for years with an a few dips into development.  I second
| Andrew's idea.  I like the idea of a quiet parm _much_ more than a default quiet mode.

which is already there, of course.  and it works well -- i use it
often.  however, i've seen at least one distro override it with a
sysctl during init-scripts.  bah.  :(

--
~Randy
