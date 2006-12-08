Return-Path: <linux-kernel-owner+w=401wt.eu-S1426062AbWLHRmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1426062AbWLHRmn (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 12:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760784AbWLHRmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 12:42:43 -0500
Received: from free.hands.com ([83.142.228.128]:59807 "EHLO free.hands.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760782AbWLHRmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 12:42:42 -0500
Date: Fri, 8 Dec 2006 17:42:21 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Jiri Kosina <jikos@jikos.cz>
Cc: linux-kernel@vger.kernel.org, kernel-discuss@handhelds.org
Subject: Re: parallel boot device initialisation (kernel-space not userspace)
Message-ID: <20061208174221.GE4666@lkcl.net>
References: <4758137481lkcl@lkcl.net> <Pine.LNX.4.64.0612081737510.1665@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612081737510.1665@twin.jikos.cz>
User-Agent: Mutt/1.5.11+cvs20060403
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 05:38:47PM +0100, Jiri Kosina wrote:
> On Fri, 8 Dec 2006, Luke Kenneth Casson Leighton wrote:
> 
> > I Have A Great Idea(tm) and would like to describe it concisely to see 
> > if anyone likes it and hopefully hasn't thought of it before so i'm not 
> > consuming people's time. The idea is: parallel device initialisation of 
> > built-in modules, to reduce kernel boot time.
> 
> Have you looked at CONFIG_PCI_MULTITHREAD_PROBE which is already present 
> in recent kernels?
 
  ah _ha_.  thank you!

 honestly? no - because the small devices i'm compiling for don't have a
 pci bus, ha ha :)

 but seriously - thank you for pointing that out, i'll definitely
 investigate it.

 l.

-- 
--
lkcl.net - mad free software computer person, visionary and poet.
--
