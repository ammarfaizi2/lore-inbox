Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWDXUUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWDXUUZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 16:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWDXUUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 16:20:25 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:44185 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751218AbWDXUUX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 16:20:23 -0400
Subject: Re: Removing .tmp_versions considered harmful
From: Pavel Roskin <proski@gnu.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1145908684.3116.65.camel@laptopd505.fenrus.org>
References: <1145593342.2904.30.camel@dv>
	 <20060421073216.GA17492@mars.ravnborg.org>  <1145908527.2292.39.camel@dv>
	 <1145908684.3116.65.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Apr 2006 16:19:36 -0400
Message-Id: <1145909976.2292.52.camel@dv>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, 2006-04-24 at 21:58 +0200, Arjan van de Ven wrote:
> On Mon, 2006-04-24 at 15:55 -0400, Pavel Roskin wrote:
> > Hello, Sam!
> > 
> > How about following patch?  Something needs to be done before 2.6.17.
> > Complaints about .tmp_versions are almost in every list about wireless
> > drivers I'm subscribed to.
> 
> seems all wireless drivers stole eachothers broken makefiles then ;)

There is is some similarity, and it's a good thing.

> Makes it also easy to fix I suppose

Could you please elaborate?  How can it be fixed?  Do you know any
external module that doesn't have this problem?

If you have a could of minutes, please look at Orinoco, which probably
has the simplest build system, yet it suffers from the .tmp_versions
problem.  The Subversion repository is here
http://sourceforge.net/svn/?group_id=44338

To check the main development branch, please use
svn co https://svn.sourceforge.net/svnroot/orinoco/trunk orinoco

This is the Makefile:
http://svn.sourceforge.net/viewcvs.cgi/*checkout*/orinoco/trunk/Makefile

What would you fix?

-- 
Regards,
Pavel Roskin

