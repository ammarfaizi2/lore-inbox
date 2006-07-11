Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWGKRzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWGKRzE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 13:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWGKRzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 13:55:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45972 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751125AbWGKRzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 13:55:02 -0400
Date: Tue, 11 Jul 2006 13:52:39 -0400
From: Dave Jones <davej@redhat.com>
To: Stephane Eranian <eranian@hpl.hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 adds smp_call_function_single
Message-ID: <20060711175239.GI5362@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Stephane Eranian <eranian@hpl.hp.com>, linux-kernel@vger.kernel.org
References: <20060711132422.GB28851@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711132422.GB28851@frankl.hpl.hp.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 06:24:22AM -0700, Stephane Eranian wrote:
 > Hello,
 > 
 > Continiung the series of small patches necessary for the perfmon subsystem, here
 > is a patch that adds support for the smp_call_function_single() function for i386.
 > It exists for almost all other architectures but i386. The perfmon subsystem
 > needs it in one case to free some state on a designated remote CPU.
 > 
 > Changelog:
 > 	- adds smp_call_function_single() to i386 tree. This function
 > 	  is used to invoked a procedure on a designated remote CPU.

The naming seems a little strange to me.  Something like
run_on_cpu() would be clearer.  Less keystrokes too :)

		Dave

-- 
http://www.codemonkey.org.uk
