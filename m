Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263586AbTJWP2N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 11:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbTJWP2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 11:28:13 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:8422 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263586AbTJWP2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 11:28:11 -0400
Date: Thu, 23 Oct 2003 08:27:26 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Fredrik Tolf <fredrik@dolda2000.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Elevator bug in concert with usb-storage
Message-ID: <20031023082726.A20073@beaverton.ibm.com>
References: <16279.15393.575929.983297@pc7.dolda2000.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16279.15393.575929.983297@pc7.dolda2000.com>; from fredrik@dolda2000.com on Thu, Oct 23, 2003 at 04:25:37AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 23, 2003 at 04:25:37AM +0200, Fredrik Tolf wrote:
> Hello,
> 
> I believe that there is a bug in the usb-storage code. I'm using
> 2.6.0-test8-mm1, but I have experienced this in essentially all
> 2.6.0-test* kernels. Mostly anytime when I remove a usb-storage device
> (especially before umounting it), I get a SEGV followed by general
> unstability in the SCSI subsys.

Try Mike's patch:

http://marc.theaimsgroup.com/?l=linux-scsi&m=106646263401437&w=2

-- Patrick Mansfield
