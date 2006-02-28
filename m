Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932594AbWB1XWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbWB1XWe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 18:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932699AbWB1XWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 18:22:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44711 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932594AbWB1XWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 18:22:34 -0500
Date: Tue, 28 Feb 2006 15:21:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [patch] i386: port ATI timer fix from x86_64 to i386
Message-Id: <20060228152124.616e6c1c.akpm@osdl.org>
In-Reply-To: <200602281619_MC3-1-B984-ED75@compuserve.com>
References: <200602281619_MC3-1-B984-ED75@compuserve.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> wrote:
>
> Disable timer routing over 8254 when an ATI chipset is detected
>  (autodetect is only implemented for ACPI, but these are new systems
>  and should be using ACPI anyway.)  Adds boot options for manually
>  disabling and enabling this feature. Also adds a note to the timer
>  error message caused by this change explaining that this error
>  is expected on ATI chipsets.

umm, why did you write this patch?  Presumably it's fixing something, but
what?
