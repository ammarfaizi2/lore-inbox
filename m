Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265195AbUJLPGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265195AbUJLPGE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 11:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264991AbUJLPEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 11:04:38 -0400
Received: from lists.us.dell.com ([143.166.224.162]:41163 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S264648AbUJLPCa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 11:02:30 -0400
Date: Tue, 12 Oct 2004 10:02:26 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.9-rc3-mm2] EDD: use EXTENDED READ command, add CONFIG_EDD_SKIP_MB
Message-ID: <20041012150226.GA32018@lists.us.dell.com>
References: <200410090117_MC3-1-8BDA-288E@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410090117_MC3-1-8BDA-288E@compuserve.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 09, 2004 at 01:13:58AM -0400, Chuck Ebbert wrote:
> Matt Domsch wrote:
> 
> > Then BIOS says you've got two more disks.
> > Both disks 82 and 83 look remarkably small (20808 sectors each,
> > ~10MB).
>
>  Some Dell notebooks do this, IIRC.  Try removing the HD from a Latitude
> CPi or CPiA and then booting from a floppy distro like tomsrtbt (from
> www.toms.net). It's been a while but that 20808 number looks awfully
> familiar...

My Latitude CPiA does not exhibit this, both with a rather old BIOS
and with the newest BIOS.  I'd appreciate hearing of other systems
that do though.  If it's a common occurance, I should be able to deal
with that as a special case.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
