Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbTEKWcq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 18:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbTEKWcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 18:32:46 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:51349
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261328AbTEKWcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 18:32:45 -0400
Subject: Re: The disappearing sys_call_table export.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Yoav Weiss <ml-lkml@unpatched.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0305120115440.2983-100000@marcellos.corky.net>
References: <Pine.LNX.4.44.0305120115440.2983-100000@marcellos.corky.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052689591.30506.9.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 May 2003 22:46:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-05-11 at 23:32, Yoav Weiss wrote:
> >   Not on the systems I've seen.  Max log file size is 4GB and the
> > logs are on their own partition.  If the file fills up the system
> > crashes immediately and only administrators can log in after reboot
> > until the logs are archived.
> 
> Why would anyone design a system like that ?!
> The logging of every security system is prone to flooding.  You may have
> noticed that your syslog sometimes spits "Last message repeated N times"
> so it won't repeat itself.  A system that doesn't deal with this issue in
> any way can't be secure.  There are a lot of methods to deal with it but I

Security to some people means that nothing happens unrecorded. Most high
security environments treat DoS attacks as the least interesting. You
knocked down my military server - who cares. You stole my list of secret
command centres - Im deeply upset.

Security requirements are heavily dependant on role and people sometimes
forget that. Being down is bad news for an ecommerce site but in many
other situations its infinite preferably to most other situations

