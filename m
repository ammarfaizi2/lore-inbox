Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932507AbVHRWqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbVHRWqL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 18:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbVHRWqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 18:46:10 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:40921 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932507AbVHRWqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 18:46:09 -0400
Subject: Re: [PATCH 2.6.13-rc6 1/2] New Syscall: get rlimits of any process
	(update)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: e8607062@student.tuwien.ac.at, linux-kernel <linux-kernel@vger.kernel.org>,
       Elliot Lee <sopwith@redhat.com>
In-Reply-To: <1124389061.5973.33.camel@mindpipe>
References: <1124326652.8359.3.camel@w2>  <p7364u40zld.fsf@verdi.suse.de>
	 <1124381951.6251.14.camel@w2>  <1124389061.5973.33.camel@mindpipe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 19 Aug 2005 00:13:31 +0100
Message-Id: <1124406811.20755.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-08-18 at 14:17 -0400, Lee Revell wrote:
> Maybe the distros need to just increase the default FD limit to 1024.  I
> hit this constantly with gtk-gnutella, if try to download a file that's
> available on more than 1024 hosts it will open sockets until it hits
> that limit then bomb out.

Sounds like a remarkably badly designed application. The author should
perhaps look at the papers on tcp capture and efficiency unless they
have a truely remarkably huge network pipe.

