Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbTEALon (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 07:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbTEALom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 07:44:42 -0400
Received: from siaab2ab.compuserve.com ([149.174.40.130]:47841 "EHLO
	siaab2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S261222AbTEALoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 07:44:39 -0400
Date: Thu, 1 May 2003 07:54:03 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Loading a module multtiple times
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305010756_MC3-1-36E1-624@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, it's a 2.5 thing: modules know their own name.  This is because
> (1) the names are used to set new-style boot parameters, (2) needing
> to insert two modules is usually wrong, since how would that work if
> the module was built-in?
> 
> It also opens us up to the possibility of a list of built-in modules,
> if we wanted to.

  The list of built-ins would be really, really nice -- it would
beat the heck out of digging through the .config and/or going
back to the build machine and doing 'make menuconfig' just to
see what's in there.

------
 Chuck
