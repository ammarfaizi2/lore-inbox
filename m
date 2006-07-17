Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWGQPb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWGQPb0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 11:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbWGQPb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 11:31:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35781 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750848AbWGQPbZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 11:31:25 -0400
Date: Mon, 17 Jul 2006 11:30:10 -0400
From: Dave Jones <davej@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG() in exit.c triggers in -git5
Message-ID: <20060717153010.GB17898@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060713204520.GB3482@redhat.com> <1153095493.17406.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153095493.17406.5.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2006 at 08:18:13PM -0400, Steven Rostedt wrote:
 > Looking at the above call trace, I have to say things are really screwed
 > up.  

Turns out this was caused by Roland McGrath's utrace patch.
mainline is unaffected. My bad for not testing that first.

		Dave
-- 
http://www.codemonkey.org.uk
