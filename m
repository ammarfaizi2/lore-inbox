Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262105AbVDFFP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbVDFFP3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 01:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbVDFFP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 01:15:29 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:12015 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262090AbVDFFPW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 01:15:22 -0400
To: davidm@hpl.hp.com
cc: Christoph Lameter <clameter@engr.sgi.com>, Andi Kleen <ak@muc.de>,
       Christoph Lameter <clameter@sgi.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mel Gorman <mel@csn.ul.ie>, linux-ia64@vger.kernel.org,
       Jens.Maurer@gmx.net
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] add a clear_pages function to clear pages of higher order 
In-reply-to: Your message of Tue, 05 Apr 2005 21:48:22 PDT.
             <16979.27158.381388.691910@napali.hpl.hp.com> 
Date: Tue, 05 Apr 2005 22:15:18 -0700
Message-Id: <E1DJ2sp-0004jm-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 05 Apr 2005 21:48:22 PDT, David Mosberger wrote:
> >>>>> On Tue, 5 Apr 2005 17:33:59 -0700 (PDT), Christoph Lameter <clameter@engr.sgi.com> said:
> 
>   Christoph> Which benchmark would you recommend for this?
> 
> I don't know about "recommend", but I think SPECweb, SPECjbb,
> the-UNIX-multi-user-benchmark-whose-name-I-keep-forgetting, and in
> general anything that involves process-activity and/or large working
> sets might be interesting (in other words: anything but
> microbenchmarks; I'm afraid).

SpecSDET, Aim7 or ReAim from OSDL are probably what you are thinking
of.

gerrit
