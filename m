Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbVCVJa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbVCVJa7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 04:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbVCVJa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 04:30:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:4835 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262585AbVCVJaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 04:30:55 -0500
Date: Tue, 22 Mar 2005 10:30:48 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Valdis.Kletnieks@vt.edu
Cc: jmerkey <jmerkey@utah-nac.org>, linux-kernel@vger.kernel.org
Subject: Re: clone() and pthread_create() segment fault in 2.4.29
Message-ID: <20050322093048.GA15079@devserv.devel.redhat.com>
References: <423F13EA.6050007@utah-nac.org> <1111431021.6952.73.camel@laptopd505.fenrus.org> <423F1852.3070902@utah-nac.org> <20050321190721.GA19194@devserv.devel.redhat.com> <200503220431.j2M4VNKF015112@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503220431.j2M4VNKF015112@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 11:31:22PM -0500, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 21 Mar 2005 20:07:21 +0100, Arjan van de Ven said:
> > On Mon, Mar 21, 2005 at 11:54:10AM -0700, jmerkey wrote:
> 
> > > which 2.4 kernels will work properly on RH ES release 3, Taroon Update 4. 
> > 
> > Only kernels with NPTL in, which for 2.4 limits you to the RH supplied one.
> 
> Well, strictly speaking, it's all GPL'ed, so Jeff is certainly free to take
> the .src.rpm of the RedHat kernel, use rpm2cpio to extract the NPTL patches
> from it, and forward port it to the 2.4.NN of his choice...

oh of course. I didn't actually consider that since it'd be a LOT of work
(speaking from experience). It could easily be 4 to 6 weeks full time work
to get the thing working well. Seriously NotFunny(tm). 
