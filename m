Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265427AbUBPIW2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 03:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265433AbUBPIW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 03:22:28 -0500
Received: from gate.in-addr.de ([212.8.193.158]:60905 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S265427AbUBPIWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 03:22:25 -0500
Date: Mon, 16 Feb 2004 09:19:45 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>, Joe Thornber <thornber@redhat.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: dm core patches
Message-ID: <20040216081945.GF20998@marowsky-bree.de>
References: <20040210163548.GC27507@reti> <20040211101659.GF3427@marowsky-bree.de> <20040211103541.GW27507@reti> <20040212185145.GY21298@marowsky-bree.de> <20040212201340.GB1898@reti> <20040213151213.GR21298@marowsky-bree.de> <20040213153936.GF15736@reti> <1076688539.4441.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1076688539.4441.2.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.1i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-02-13T17:08:59,
   Arjan van de Ven <arjanv@redhat.com> said:

> one thing you can do is provide a way for drivers to wake the userspace
> tester early. Say by default it polls every minute, but if the fiber
> channel driver gets a LIP UP event it (via a central API) makes the
> userspace daemon *now*.

I may be missing something obvious, but a LIP UP should be accompanied
with a round of 'device detections' on that link, which already should
trigger a few hotplug events, no?

So this seems pretty much solved.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	      \ ever tried. ever failed. no matter.
SUSE Labs			      | try again. fail again. fail better.
Research & Development, SUSE LINUX AG \ 	-- Samuel Beckett

