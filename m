Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbVBORPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVBORPD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 12:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVBORLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 12:11:55 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:47250 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261795AbVBORJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 12:09:11 -0500
Date: Tue, 15 Feb 2005 18:09:44 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Kenan Esau <kenan.esau@conan.de>
Cc: dtor_core@ameritech.net, harald.hoyer@redhat.de,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
Message-ID: <20050215170944.GB1568@ucw.cz>
References: <20050211201013.GA6937@ucw.cz> <1108457880.2843.5.camel@localhost> <20050215134308.GE7250@ucw.cz> <d120d500050215064357fa60c@mail.gmail.com> <1108487008.2843.21.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108487008.2843.21.camel@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 06:03:28PM +0100, Kenan Esau wrote:

> All B-Series Lifebooks have the same touchscreen-hardware. But Dmitri's
> concern is correct -- at the moment I would enforce the LBTOUCH-protocol
> on external mice...
> 
> I have to fix this. I will additionally to the DMI stuff use "Status
> Request". On a "Request ID"-Command the Device always answers with a
> 0x00 -- could this also be helpfull?

No. That's the standard response for common PS/2 mice.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
