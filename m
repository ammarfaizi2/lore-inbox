Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264980AbTFQWef (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 18:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264981AbTFQWef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 18:34:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16651 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264980AbTFQWee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 18:34:34 -0400
Date: Tue, 17 Jun 2003 23:48:27 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: davidm@hpl.hp.com, Riley Williams <Riley@Williams.Name>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] input: Fix CLOCK_TICK_RATE usage ...  [8/13]
Message-ID: <20030617234827.K32632@flint.arm.linux.org.uk>
Mail-Followup-To: Vojtech Pavlik <vojtech@suse.cz>, davidm@hpl.hp.com,
	Riley Williams <Riley@Williams.Name>, linux-kernel@vger.kernel.org
References: <16110.4883.885590.597687@napali.hpl.hp.com> <BKEGKPICNAKILKJKMHCAEEOAEFAA.Riley@Williams.Name> <16111.37901.389610.100530@napali.hpl.hp.com> <20030618002146.A20956@ucw.cz> <16111.38768.926655.731251@napali.hpl.hp.com> <20030618004233.B21001@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030618004233.B21001@ucw.cz>; from vojtech@suse.cz on Wed, Jun 18, 2003 at 12:42:33AM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 12:42:33AM +0200, Vojtech Pavlik wrote:
> an arch-dependent #define is needed. I don't care about the location
> (timex.h indeed seems inappropriate, maybe the right location is
> pcspkr.c ...), or the name, but something needs to be done so that the
> beeps have the same sound the same on all archs.

This may be something to aspire to, but I don't think its achievable
given the nature of PC hardware.  Some "PC speakers" are actually
buzzers in some cases rather than real loudspeakers which give a
squark rather than a beep.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

