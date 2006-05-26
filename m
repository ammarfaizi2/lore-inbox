Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWEZSFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWEZSFc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 14:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWEZSFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 14:05:32 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:16089 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751213AbWEZSFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 14:05:32 -0400
Subject: Re: 2.6.16-rtXYZ hangs at boot on quad Opteron
From: Steven Rostedt <rostedt@goodmis.org>
To: Clark Williams <williams@redhat.com>
Cc: Robert Crocombe <rwcrocombe@raytheon.com>,
       LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <446DF768.80205@redhat.com>
References: <44623EE0.8040300@raytheon.com>
	 <Pine.LNX.4.58.0605101540490.22959@gandalf.stny.rr.com>
	 <44628A70.1020502@raytheon.com> <44634F63.1090504@redhat.com>
	 <Pine.LNX.4.58.0605120216001.26721@gandalf.stny.rr.com>
	 <446DF768.80205@redhat.com>
Content-Type: text/plain
Date: Fri, 26 May 2006 14:05:21 -0400
Message-Id: <1148666721.9886.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert and Clark, just so you know what the patches fixed
(I've already CC'd both of you)

I just sent two patches that fix the x86_64 to Ingo.

The first one fixes the hang if you have "clocksource=xxx" in your
kernel command line.

(found here)
http://marc.theaimsgroup.com/?l=linux-kernel&m=114866005406529&q=raw

And the other fixes the hang later on after the:

Brought up 4 CPUs
testing NMI watchdog ... OK.


(found here)
http://marc.theaimsgroup.com/?l=linux-kernel&m=114866005414049&q=raw

-- Steve


