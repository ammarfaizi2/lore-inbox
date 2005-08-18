Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbVHRSRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbVHRSRo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 14:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbVHRSRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 14:17:44 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:52644 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932377AbVHRSRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 14:17:44 -0400
Subject: Re: [PATCH 2.6.13-rc6 1/2] New Syscall: get rlimits of any process
	(update)
From: Lee Revell <rlrevell@joe-job.com>
To: e8607062@student.tuwien.ac.at
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Elliot Lee <sopwith@redhat.com>
In-Reply-To: <1124381951.6251.14.camel@w2>
References: <1124326652.8359.3.camel@w2>  <p7364u40zld.fsf@verdi.suse.de>
	 <1124381951.6251.14.camel@w2>
Content-Type: text/plain
Date: Thu, 18 Aug 2005 14:17:40 -0400
Message-Id: <1124389061.5973.33.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.7 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-18 at 18:19 +0200, Wieland Gmeiner wrote:
> As an example: It seems to be a common problem with numerous services
> to run out of available file descriptors. There are several
> workarounds to this problem, the most common seems to be increasing
> the systemwide max number of filedescriptors and restarting the
> service. If you google for e.g. 'linux "too many open files"' you get
> a bunch of mailing list support requests about that problem. 

Maybe the distros need to just increase the default FD limit to 1024.  I
hit this constantly with gtk-gnutella, if try to download a file that's
available on more than 1024 hosts it will open sockets until it hits
that limit then bomb out.

1024 seems way too low these days given the proliferation of "swarming"
P2P protocols like gnutella and bittorrent.

Lee

