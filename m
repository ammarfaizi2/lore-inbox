Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVCTWqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVCTWqa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 17:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVCTWp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 17:45:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3992 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261319AbVCTWni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 17:43:38 -0500
Date: Sun, 20 Mar 2005 17:42:34 -0500
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386/x86_64 mpparse.c: kill maxcpus
Message-ID: <20050320224233.GB26230@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
References: <20050320192549.GP4449@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050320192549.GP4449@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2005 at 08:25:49PM +0100, Adrian Bunk wrote:
 > Do we really need a global variable that does only hold the value of 
 > NR_CPUS?

Yes.
 
NR_CPUS = compile time
maxcpus = boot command line at runtime.

		Dave

