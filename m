Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbVHSAP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbVHSAP7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 20:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbVHSAP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 20:15:59 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:40640 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932529AbVHSAP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 20:15:58 -0400
Subject: Re: [PATCH 2.6.13-rc6 1/2] New Syscall: get rlimits of any process
	(update)
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: e8607062@student.tuwien.ac.at, linux-kernel <linux-kernel@vger.kernel.org>,
       Elliot Lee <sopwith@redhat.com>
In-Reply-To: <1124411388.20755.20.camel@localhost.localdomain>
References: <1124326652.8359.3.camel@w2>  <p7364u40zld.fsf@verdi.suse.de>
	 <1124381951.6251.14.camel@w2>  <1124389061.5973.33.camel@mindpipe>
	 <1124406811.20755.16.camel@localhost.localdomain>
	 <1124407014.10991.31.camel@mindpipe>
	 <1124411388.20755.20.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 18 Aug 2005 20:15:55 -0400
Message-Id: <1124410556.10991.49.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.7 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-19 at 01:29 +0100, Alan Cox wrote:
> On Iau, 2005-08-18 at 19:16 -0400, Lee Revell wrote:
> > A search for a 200MB file tells you it's available on 2000 hosts, all of
> > whom are on dialup.  
> 
> What about the real world ?
> 

OK that was a poorly contrived example.  Anyway the specific numbers
don't matter as much; it's actually quite a common scenario to run out
of FDs before you can fill the pipe.  It happens to me about once a
week.

Modern P2P protocols all seem to use some type of "swarming".  IIRC the
inspiration was the DDOS attacks of the late 90s - thousands of hosts on
slow connections can fill even the fattest pipe.

Lee

