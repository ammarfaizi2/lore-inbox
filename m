Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266721AbUIOQNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266721AbUIOQNb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 12:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266717AbUIOQLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 12:11:19 -0400
Received: from convulsion.choralone.org ([212.13.208.157]:12041 "EHLO
	convulsion.choralone.org") by vger.kernel.org with ESMTP
	id S266547AbUIOPwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 11:52:25 -0400
Date: Wed, 15 Sep 2004 16:52:15 +0100
From: Dave Jones <davej@redhat.com>
To: Tigran Aivazian <tigran@veritas.com>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: Latest microcode data from Intel.
Message-ID: <20040915155215.GB24892@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Tigran Aivazian <tigran@veritas.com>,
	Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.3.96.1040915111445.10950I-100000@gatekeeper.tmr.com> <Pine.LNX.4.44.0409151641430.3504-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0409151641430.3504-100000@einstein.homenet>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 04:43:59PM +0100, Tigran Aivazian wrote:

 > The microcode driver handles the case of different types of CPUs in an SMP 
 > system internally. Namely, it selects the appropriate microcode data 
 > chunks for each CPU and then uploads them correctly to each one. Anyway, 
 > it only works for Intel processors, so AMD is not in the equation anyway 
 > (unless I discover that AMD processors support similar feature and enhance 
 > the driver to support it).

They do support the feature, but AMD folks have stated on this list that they
don't intend to release any updates other than through their
conventional means (Ie, BIOS updates).

There was a post just 2-3 weeks ago where someone patched microcode.c to
work on AMD64s.

		Dave

