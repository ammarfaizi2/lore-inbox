Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbULBUbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbULBUbY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 15:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbULBUbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 15:31:24 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:9025 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261753AbULBUaO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 15:30:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:return-path:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=UNrK6/ccPvHaUyl+sDdMiFGukFW/rxSLYlupepcwXhqFKowupgPUNOG0q51tm5UzCaT+EaKx+khpVNdNH9xjfDHV0elRSbkQ7JBb5hAcFGPtXZNRzk0FxMfwbJbyRqyvMxAfJxmExtcBGNxSGit+7JYiuaeIrYTnIFm88Efv7Q4=
Date: Thu, 2 Dec 2004 21:30:08 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: page fault scalability patch V12 [0/7]: Overview and
 performance tests
Message-Id: <20041202213008.2f2c3fea.diegocg@gmail.com>
In-Reply-To: <41AF7726.4000509@pobox.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
	<Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>
	<Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>
	<Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0412011608500.22796@ppc970.osdl.org>
	<41AEB44D.2040805@pobox.com>
	<20041201223441.3820fbc0.akpm@osdl.org>
	<41AEBAB9.3050705@pobox.com>
	<20041202204838.04f33a8c.diegocg@gmail.com>
	<41AF7726.4000509@pobox.com>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 02 Dec 2004 15:12:22 -0500 Jeff Garzik <jgarzik@pobox.com>
escribió:

> > Automated .deb's and .rpm's for the -bk snapshots (and yum/apt
> > repositories) would be nice for all those people who run unsupported
> > distros.
> 
> Now, that's a darned good idea...
> 
> Should be simple for rpm at least, given the "make rpm" target.  I 
> wonder if we have, or could add, a 'make deb' target.


There was a patch for that long time ago before 2.6 was out IIRC? I don't
know where it went (CC'ing Sam who should know ;)
