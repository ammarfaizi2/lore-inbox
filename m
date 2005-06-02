Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVFBRb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVFBRb1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 13:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVFBRb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 13:31:27 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:29689 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261202AbVFBRbZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 13:31:25 -0400
Subject: Re: [PATCH] Abstracted Priority Inheritance for RT
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       sdietrich@mvista.com, rostedt@goodmis.org,
       inaky.perez-gonzalez@intel.com
In-Reply-To: <Pine.OSF.4.05.10506021713200.3853-100000@da410.phys.au.dk>
References: <Pine.OSF.4.05.10506021713200.3853-100000@da410.phys.au.dk>
Content-Type: text/plain
Organization: MontaVista
Date: Thu, 02 Jun 2005 10:31:11 -0700
Message-Id: <1117733471.20350.2.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-02 at 17:18 +0200, Esben Nielsen wrote:

> Good :-)
> I asked the question because I considered (and started but didn't
> have time) doing what you have done. I wanted to generalise the rt_mutex
> to have real rw_lock as well - which was dropped due to the
> non-deterministc behavioir even with PI. To do that I needed to have the
> recursion and the callback..

I'm not planning to do a real rw-lock, but I hope this generic PI will
help with that. I'm still not completely satisfied with this callback
structure , but I don't see a better way to do it. Do you have an
suggestions for replacing it?

Daniel

