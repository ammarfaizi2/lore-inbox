Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266210AbUARCEf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 21:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265859AbUARCEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 21:04:35 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:42638 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266210AbUARCEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 21:04:34 -0500
Date: Sun, 18 Jan 2004 02:03:01 +0000
From: Dave Jones <davej@redhat.com>
To: Niel Lambrechts <antispam@absamail.co.za>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.1 MCE falseness?] Hardware reports non-fatal error
Message-ID: <20040118020301.GA8621@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Niel Lambrechts <antispam@absamail.co.za>,
	linux-kernel@vger.kernel.org
References: <1074390255.8198.22.camel@ksyrium.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074390255.8198.22.camel@ksyrium.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 18, 2004 at 03:44:16AM +0200, Niel Lambrechts wrote:

 > I get the following problem with 2.6.1 consistently after apm resuming:
 > "ksyrium kernel: MCE: The hardware reports a non fatal, correctable
 > incident occurred on CPU 0.
 > 
 > Message from syslogd@ksyrium at Wed Jan 14 13:33:06 2004 ...
 > ksyrium kernel: Bank 1: f2000000000001c5"

As it only happens when you resume from APM, I'm inclined to believe
its a BIOS bug.  With the output of dmidecode, we could blacklist this
box to not do the nonfatal checking.

 > It does not happen on any other kernels I use (vanilla 2.4.24, SuSE 9
 > 2.4.21-166) - even though CONFIG_X86_MCE=y for both. The equipment is
 > brand-new - an IBM Thinkpad R50P - and it passes all IBM's s/w
 > diagnostic.

None of the other kernels you mention have this, its a new feature of 2.6

		Dave

