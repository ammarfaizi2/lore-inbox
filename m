Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264036AbTKDJv7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 04:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264037AbTKDJv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 04:51:58 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:42881 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S264036AbTKDJv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 04:51:57 -0500
To: "Charles Martin" <martinc@ucar.edu>
Cc: <linux-kernel@vger.kernel.org>, <martinc@atd.ucar.edu>
Subject: Re: interrupts across  PCI bridge(s) not handled
References: <000001c3a254$043d88c0$c3507580@atdsputnik>
From: Jes Sorensen <jes@trained-monkey.org>
Date: 04 Nov 2003 04:51:53 -0500
In-Reply-To: <000001c3a254$043d88c0$c3507580@atdsputnik>
Message-ID: <yq0vfq0jwau.fsf@trained-monkey.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Charles" == Charles Martin <martinc@ucar.edu> writes:

Charles> They are now getting handled properly, i.e. I am receiveing
Charles> interrupts from the boards located in the backplane extender.
Charles> This is with 2.4.22.

Charles> I didn't realize that ACPI is related to interrupt management
Charles> as well as power control. Is there any downside to using
Charles> ACPI?

Yep it does ;-( IA64 relies exclusively on ACPI for irq routing and on
x86 you are seeing more and more hardware that requires it as well,
notably Sony laptops such as the R505 series will not see interrupts
assigned to their cardbus bridge without ACPI interrupt routing.

As for downsides, take a look at the ACPI spec and judge for
yourself. I'll refrain from commenting ;-)

Cheers,
Jes
