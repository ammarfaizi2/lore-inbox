Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271807AbTHMLGl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 07:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271811AbTHMLGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 07:06:41 -0400
Received: from colin2.muc.de ([193.149.48.15]:17928 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S271807AbTHMLGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 07:06:39 -0400
Date: 13 Aug 2003 13:06:36 +0200
Date: Wed, 13 Aug 2003 13:06:36 +0200
From: Andi Kleen <ak@colin2.muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: thunder7@xs4all.nl, linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>,
       Zwane Mwaikambo <zwane@holomorphy.com>,
       Dave Jones <davej@codemonkey.org.uk>
Subject: Re: 2.6.0-test3-mm1: scheduling while atomic (ext3?)
Message-ID: <20030813110636.GB26019@colin2.muc.de>
References: <20030813045638.GA9713@middle.of.nowhere> <20030813014746.412660ae.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030813014746.412660ae.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But if a prefetch of zero oopses then we should be oopsing in there all the
> time.
> 

If it's an Opteron then it's a known errata (#91 iirc). Update your BIOS in 
this case.

The x86-64 kernel port also has a workaround for this (adding exception
handling to the prefetches)

-Andi

