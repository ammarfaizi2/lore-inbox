Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbUK0TmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbUK0TmW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 14:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbUK0TmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 14:42:22 -0500
Received: from hermes.domdv.de ([193.102.202.1]:25099 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261314AbUK0TmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 14:42:21 -0500
Message-ID: <41A8D89B.9090909@domdv.de>
Date: Sat, 27 Nov 2004 20:42:19 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040918
X-Accept-Language: en-us, en, de
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Javier Villavicencio <javierv@migraciones.gov.ar>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: no entropy and no output at /dev/random  (quick question)
References: <41A7EDA1.5000609@migraciones.gov.ar> <Pine.LNX.4.53.0411272019350.27610@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0411272019350.27610@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> I doubt that timer and eth* are a non-predictable source. As such, they should
> not contribute to the entropy. Better is the keyboard and/or mouse. SSH traffic
> is network traffic, and if you send it to a network card, you can expect an
> interrupt at <time>... prdictable.

Timer, ok. But network - only if you are in full control of the network 
segment the system is attached to which may be the case for your private 
network but usually you can't predict what network traffic is actually 
going on.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
