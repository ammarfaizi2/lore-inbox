Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVDDKsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVDDKsK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 06:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVDDKsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 06:48:10 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:45024 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261214AbVDDKsH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 06:48:07 -0400
Subject: Re: AMD64 Machine hardlocks when using memset
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Hancock <hancockr@shaw.ca>
Cc: Paul Jackson <pj@engr.sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <424E24A5.4040102@shaw.ca>
References: <3NZDp-4yY-7@gated-at.bofh.it> <3OmgF-6HV-17@gated-at.bofh.it>
	 <3OmgF-6HV-15@gated-at.bofh.it> <3Oy8m-74-15@gated-at.bofh.it>
	 <424E0424.7080308@shaw.ca> <20050401201105.4a03bda1.pj@engr.sgi.com>
	 <424E24A5.4040102@shaw.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1112611507.8664.544.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 04 Apr 2005 11:45:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-04-02 at 05:50, Robert Hancock wrote:
> I'm wondering if one does a ton of these cache-bypassing stores whether 
> something gets hosed because of that. Not sure what that could be 
> though. I don't imagine the chipset is involved with any of that on the 
> Athlon 64 - either the CPU or RAM seems the most likely suspect to me

The glibc version is essentially the "perfect" copy function for the
CPU. If you have any bus/memory problems or chipset bugs it will bite
you.

Alan

