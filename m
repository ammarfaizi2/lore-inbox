Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267952AbTGXJsR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 05:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271420AbTGXJsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 05:48:17 -0400
Received: from sinma-gmbh.17.mind.de ([212.21.92.17]:41223 "EHLO gw.enyo.de")
	by vger.kernel.org with ESMTP id S267952AbTGXJsQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 05:48:16 -0400
To: "Bryan D. Stine" <admin@kentonet.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test1] ACPI slowdown
References: <878yqpptez.fsf@deneb.enyo.de> <bfn3rj$lql$1@gatekeeper.tmr.com>
	<1059002183.1484.18.camel@gaia>
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: "Bryan D. Stine" <admin@kentonet.net>,
 linux-kernel@vger.kernel.org
Date: Thu, 24 Jul 2003 12:03:22 +0200
In-Reply-To: <1059002183.1484.18.camel@gaia> (Bryan D. Stine's message of
 "23 Jul 2003 19:16:23 -0400")
Message-ID: <87el0gfdhx.fsf@deneb.enyo.de>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bryan D. Stine" <admin@kentonet.net> writes:

> I had that problem with my old Athlon TBird. Changing config to make
> thermal a module and not loading it solved my problem. I don't know how
> to change the thermal limits from within the system using ACPI.

Maybe it's related to the BIOS configuration.  You can configure
limits there, and they seem to match those that are displayed under
/proc.

However, I still wonder if the 57 °C figure is something I should
worry about (although the machine has been running stable for years).
