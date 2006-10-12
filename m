Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161247AbWJLHDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161247AbWJLHDK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 03:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161531AbWJLHDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 03:03:10 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:50887 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S1161247AbWJLHDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 03:03:06 -0400
Date: Thu, 12 Oct 2006 00:02:54 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/21] 2.6.18 perfmon2 : introduction
Message-ID: <20061012070254.GA30888@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200610091410.k99EA78i025999@frankl.hpl.hp.com> <20061011181410.e5916295.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061011181410.e5916295.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

On Wed, Oct 11, 2006 at 06:14:10PM -0700, Andrew Morton wrote:
> On Mon, 9 Oct 2006 07:10:07 -0700
> Stephane Eranian <eranian@frankl.hpl.hp.com> wrote:
> 
> > Perfmon2 is a new kernel subsystem which provides access to the
> > hardware performance counters present all all modern processors.
> 
> patch 21/21 got lost - please resend.

The first patch is numbered 00 (introduction), so nothing got lost.

> 
> How does one test this?  A short-form perfmon-for-dummies guide would be
> nice..

Yes, I agree with you. However, I would suggest you download the libpfm package
from:
	http://perfmon2.sf.net

Click on project files.

This package contains very simple examples on how one can use the interface.

I am currently working on fixing the remaining issues you reported in your feedback.
As for the biggest change which is to drop UUID in favor of strings, I have decided
to make the switch.

-- 
-Stephane
