Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316768AbSIJUg3>; Tue, 10 Sep 2002 16:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318113AbSIJUg3>; Tue, 10 Sep 2002 16:36:29 -0400
Received: from crack.them.org ([65.125.64.184]:16647 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S316768AbSIJUg1>;
	Tue, 10 Sep 2002 16:36:27 -0400
Date: Tue, 10 Sep 2002 16:41:20 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Frank Peters <frank.peters@intralab.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ptrace probs?
Message-ID: <20020910204120.GA4230@nevyn.them.org>
Mail-Followup-To: Frank Peters <frank.peters@intralab.de>,
	linux-kernel@vger.kernel.org
References: <000d01c258fb$8cf72d40$0242a8c0@alpha.de> <20020910182125.GA30999@nevyn.them.org> <008b01c25911$60c7ad10$0242a8c0@alpha.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008b01c25911$60c7ad10$0242a8c0@alpha.de>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2002 at 10:31:00PM +0100, Frank Peters wrote:
> Kernel: 2.4.18
> maybe it's a glibc prob.

Try waitpid (PID, &status, 0) first.  You can't do anything until the
process stops, that's normal.


-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
