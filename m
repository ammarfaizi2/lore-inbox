Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264092AbUCZRCx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 12:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264088AbUCZRCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 12:02:52 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:21454 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S264092AbUCZRCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 12:02:51 -0500
Date: Fri, 26 Mar 2004 16:59:54 +0000
From: Dave Jones <davej@redhat.com>
To: billy rose <billyrose@cox-internet.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: arch 386
Message-ID: <20040326165953.GB25210@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	billy rose <billyrose@cox-internet.com>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <4063D30C.30305@cox-internet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4063D30C.30305@cox-internet.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2004 at 12:51:56AM -0600, billy rose wrote:
 > i sent an email last night, but i think my email host was down so i will 
 > try again. since 2.6.x can preempt, what do you think about using a call 
 > gate in place of int 80? sysenter was implemented in this fashion for 
 > p4's, but there are a lot of pre p4 boxes still out there. 

Most of those pre p4 boxes can also use sysenter.
It's been there since the Pentium Pro (though hardware bugs made it
unusable there, at least on the earlier revs).

		Dave

