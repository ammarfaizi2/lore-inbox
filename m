Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbTL2MsK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 07:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263310AbTL2MsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 07:48:10 -0500
Received: from frankvm.xs4all.nl ([80.126.170.174]:32902 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S263244AbTL2MsI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 07:48:08 -0500
Date: Mon, 29 Dec 2003 13:52:40 +0100
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 can run with HZ==0!
Message-ID: <20031229125240.GA4055@janus>
Mail-Followup-To: Frank van Maarseveen <frankvm@xs4all.nl>,
	Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
References: <20031228230522.GA1876@janus> <1072691126.5223.5.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072691126.5223.5.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 29, 2003 at 10:45:27AM +0100, Arjan van de Ven wrote:
> 
> not all motherboards can deal with HZ=1000.... seems yours is one of
> thise.

But it seems to work. I would expect it to fail quite soon right at or after
boot, not after a day once every few weeks (assuming it was the cause).

> your patch is *highly* inadequate to get HZ=1000 working well in 2.4....
> it needs to be about 10x bigger with fixing more userspace api's...

Can you give me an example?

HZ for x386 is 100 by definition and there aren't that many system calls
and /proc files which expose jiffies to userspace.

The uptime will be rather limited with 32 bits jiffies ;-) but I can live with that.

-- 
Frank
