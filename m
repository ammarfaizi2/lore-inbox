Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264407AbTFKMV4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 08:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264412AbTFKMV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 08:21:56 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:56035 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264407AbTFKMVz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 08:21:55 -0400
Date: Wed, 11 Jun 2003 18:08:18 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       greg@kroah.com
Subject: Re: Misc 2.5 Fixes: cp-user-vicam
Message-ID: <20030611123818.GA10840@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030610100905.GD2194@in.ibm.com> <20030610100950.GE2194@in.ibm.com> <20030610101035.GF2194@in.ibm.com> <20030610101121.GG2194@in.ibm.com> <20030610101318.GH2194@in.ibm.com> <20030610101503.GI2194@in.ibm.com> <20030610101801.GJ2194@in.ibm.com> <20030610102024.GK2194@in.ibm.com> <20030611104823.GB3718@in.ibm.com> <1055333897.2083.5.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055333897.2083.5.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 01:18:17PM +0100, Alan Cox wrote:
> On Mer, 2003-06-11 at 11:48, Dipankar Sarma wrote:
> > The patch I sent yesterday is bad, turns out I didn't enable vicam
> > config option while compiling. Here is a replacement patch that
> > actually compiles.
> 
> This looks odd. 2.5 unlike 2.4 video4linux has the wrapper copy the
> structures in and out

Which ioctl cmds, gets or sets ? In 2.5, it seems sets are copying
in and gets are copying the structures out as one would expect.

That said, some like VIDIOCSCHAN and VIDIOCSWIN in vicam don't 
seem to really do anything.

Thanks
Dipankar
