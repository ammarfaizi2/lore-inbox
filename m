Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbTJWAPy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 20:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbTJWAPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 20:15:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28689 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261347AbTJWAPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 20:15:53 -0400
Date: Thu, 23 Oct 2003 01:15:47 +0100
From: Dave Jones <davej@redhat.com>
To: "Joseph D. Wagner" <theman@josephdwagner.info>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FEATURE REQUEST: Specific Processor Optimizations on x86 Architecture
Message-ID: <20031023001547.GA18395@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Joseph D. Wagner" <theman@josephdwagner.info>,
	linux-kernel@vger.kernel.org
References: <200310221855.15925.theman@josephdwagner.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310221855.15925.theman@josephdwagner.info>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 22, 2003 at 06:55:15PM +0600, Joseph D. Wagner wrote:

 > If you select Pentium III, the -march flag is set to pentium3.
 > If you select Pentium 4, the -march flag is set to pentium4.

Already done for 2.6

 > If you select Athlon 4, the -march flag is set to athlon-4.
 > If you select Athlon XP, the -march flag is set to athlon-xp.

Last time I looked these made absolutely no difference to performance
due to the only differences being on FP code.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
