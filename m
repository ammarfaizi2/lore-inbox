Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262074AbVEREGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbVEREGR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 00:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbVEREGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 00:06:16 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:60644 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262074AbVEREGL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 00:06:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I8NVaTFhGKtoU5uaP53Cqe8BiqYwIoOEfB8QuqZv7US2zA10M8ggn8redN/6xQVmv9OVuSYyQnDSNhHPI2vXbEuwADYW5uXfQpnu6m9tKIzMv8pRmD/Z0bmVO1ixnDa9vISBjJ5m4YSd4R/mwbcC56x8zwsGtgcvAw2wv1XxfP4=
Message-ID: <311601c9050517210657a20256@mail.gmail.com>
Date: Tue, 17 May 2005 22:06:11 -0600
From: "Eric D. Mudama" <edmudama@gmail.com>
Reply-To: "Eric D. Mudama" <edmudama@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Disk write cache (Was: Hyper-Threading Vulnerability)
In-Reply-To: <20050516111859.GB13387@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1115963481.1723.3.camel@alderaan.trey.hu>
	 <20050515145241.GA5627@irc.pl>
	 <Pine.LNX.4.58.0505151657230.19181@artax.karlin.mff.cuni.cz>
	 <200505151121.36243.gene.heskett@verizon.net>
	 <Pine.LNX.4.58.0505151809240.26531@artax.karlin.mff.cuni.cz>
	 <20050516111859.GB13387@merlin.emma.line.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/05, Matthias Andree <matthias.andree@gmx.de> wrote:
> I've heard that drives would be taking rotational energy from their
> rotating platters and such, but never heard how the hardware compensates
> the dilation with decreasing rotational frequency, which also requires
> changed filter settings for the write channel, block encoding, delays,
> possibly stepping the heads and so on. I don't believe these stories
> until I see evidence.

I'm pretty sure that most drives out there will immediately attempt to
safely retract or park the heads the instant that a power loss is
detected.  There's too much potential damage that can occur if the
heads aren't able to safely retract to a landing zone or ramp, that
trying to save "one more block of cached data" just isn't worth the
risk.

--eric
