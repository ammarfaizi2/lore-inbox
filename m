Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbVKYWbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbVKYWbn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 17:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbVKYWbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 17:31:43 -0500
Received: from smtp113.sbc.mail.re2.yahoo.com ([68.142.229.92]:3497 "HELO
	smtp113.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751488AbVKYWbm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 17:31:42 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: Mouse issues in -mm
Date: Fri, 25 Nov 2005 17:31:36 -0500
User-Agent: KMail/1.8.3
Cc: Andrew Morton <akpm@osdl.org>, Marc Koschewski <marc@osknowledge.org>,
       linux-kernel@vger.kernel.org, Harald Welte <laforge@netfilter.org>,
       netdev@vger.kernel.org
References: <20051123033550.00d6a6e8.akpm@osdl.org> <200511232226.44459.dtor_core@ameritech.net> <43855A50.80808@tuxrocks.com>
In-Reply-To: <43855A50.80808@tuxrocks.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200511251731.36939.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 November 2005 01:14, Frank Sorenson wrote:
> Note: I believe this issue may also be related to the mouse protocol
> extension.  I typically run with 'psmouse.proto=exps' on the kernel
> command line, and the psmouse resync patch seems to break tapping in
> that mode.

So the resync patch - is it only tapping that is broken or you also
loosing the touchpad completely?

> However, booting without proto=exps seems to continue to 
> work, even with the resync patch (though the touchpad is unusably
> sensitive--hence the use of exps in the first place).

Without the parameter your touchpad is using native ALPS protocol and
resync is disabled for it. You may have better liuck with toucpad
sensitivity using synaptics X driver.

-- 
Dmitry
