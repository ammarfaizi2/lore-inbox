Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbVLFPSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbVLFPSd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 10:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751703AbVLFPSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 10:18:32 -0500
Received: from ns.suse.de ([195.135.220.2]:53889 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751699AbVLFPSb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 10:18:31 -0500
To: "David Engraf" <engraf.david@netcom-sicherheitstechnik.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Win32 equivalent to GetTickCount systemcall (i386)
References: <1133871202.3664.34.camel@tara.firmix.at>
	<000201c5fa60$52bb53e0$0a016696@EW10>
From: Andi Kleen <ak@suse.de>
Date: 06 Dec 2005 12:48:29 -0700
In-Reply-To: <000201c5fa60$52bb53e0$0a016696@EW10>
Message-ID: <p73psoaqa5u.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David Engraf" <engraf.david@netcom-sicherheitstechnik.de> writes:
> 
> times has only 10ms resolution, we need at least 1ms.

It actually has jiffies resultion. Your measurements must have been
quite off.

-Andi
