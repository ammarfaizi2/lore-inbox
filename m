Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261604AbSJDMtO>; Fri, 4 Oct 2002 08:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261616AbSJDMtO>; Fri, 4 Oct 2002 08:49:14 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:32503 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261604AbSJDMtM>; Fri, 4 Oct 2002 08:49:12 -0400
Subject: Re: export of sys_call_table
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Levon <levon@movementarian.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021004114247.GA98207@compsoc.man.ac.uk>
References: <20021003153943.E22418@openss7.org>
	<20021003221525.GA2221@kroah.com> <20021003222716.GB14919@suse.de>
	<1033684027.1247.43.camel@phantasy> <20021003233504.GA20570@suse.de>
	<20021003235022.GA82187@compsoc.man.ac.uk>
	<mailman.1033691043.6446.linux-kernel2news@redhat.com>
	<200210040403.g9443Vu03329@devserv.devel.redhat.com>
	<20021003233221.C31444@openss7.org> 
	<20021004114247.GA98207@compsoc.man.ac.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Oct 2002 14:02:32 +0100
Message-Id: <1033736552.31839.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-04 at 12:42, John Levon wrote:
> Btw, anybody know what the BKL is actually protecting against in
> sys_nfsservctl ?

rmmod while executing an nfs call

