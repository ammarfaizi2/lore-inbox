Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264451AbUA0TXf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 14:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264927AbUA0TXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 14:23:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:60860 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264451AbUA0TXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 14:23:31 -0500
Date: Tue, 27 Jan 2004 11:18:24 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: David Weinehall <tao@debian.org>
Cc: theman@josephdwagner.info, ak@suse.de, rmps@joel.ist.utl.pt,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: Trailing blanks in source files
Message-Id: <20040127111824.7f76efe6.rddunlap@osdl.org>
In-Reply-To: <20040127191358.GI20879@khan.acc.umu.se>
References: <Pine.LNX.4.58.0401271544120.27260@joel.ist.utl.pt.suse.lists.linux.kernel>
	<p73bropfdgl.fsf@nielsen.suse.de>
	<200401271251.34926.theman@josephdwagner.info>
	<20040127191358.GI20879@khan.acc.umu.se>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jan 2004 20:13:58 +0100 David Weinehall <tao@debian.org> wrote:

| On Tue, Jan 27, 2004 at 12:51:34PM -0600, Joseph D. Wagner wrote:
| > > It seems that many files [1] in the Linux source have lines with
| > > trailing blank (space and tab) characters and some even have formfeed
| > > characters. Obviously these blank characters aren't necessary.
| > 
| > Actually, they are necessary.
| > 
| > http://www.gnu.org/prep/standards_23.html
| > http://www.gnu.org/prep/standards_24.html
| 
| Let me quote CodingStyle:
| 
| "First off, I'd suggest printing out a copy of the GNU coding standards,
|  and NOT read it.  Burn them, it's a great symbolic gesture."
| 
| That's how much relevance GNU's coding standards have to the kernel.

Thank you, I had forgotten that one and I was wondering what the
heck those web pages had to do with anything (kernel).

So please don't bother with just whitespace changes unless you
are going to cleanup a <driver | fs | module | etc> completely.

--
~Randy
kernel-janitors project:  http://janitor.kernelnewbies.org/
