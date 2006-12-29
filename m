Return-Path: <linux-kernel-owner+w=401wt.eu-S1753902AbWL2EWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902AbWL2EWS (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 23:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754069AbWL2EWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 23:22:18 -0500
Received: from smtpq3.groni1.gr.home.nl ([213.51.130.202]:48658 "EHLO
	smtpq3.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753902AbWL2EWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 23:22:17 -0500
Message-ID: <459497A3.8080001@gmail.com>
Date: Fri, 29 Dec 2006 05:20:51 +0100
From: Rene Herman <rene.herman@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Dmitry Torokhov <dtor@insightbb.com>
CC: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2.6.20-rc2] atkbd.c: Spurious ACK
References: <4592E685.5000602@gmail.com> <20061228191204.GB8940@redhat.com> <45943AE4.6080704@gmail.com> <200612282240.00784.dtor@insightbb.com>
In-Reply-To: <200612282240.00784.dtor@insightbb.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:

> The change to suppress ACKs from paic blinking is already in Linus's
> tree. I just tried booting with root=/dev/sdg and I had leds blinking
> but no messages from atkbd were seen.
> 
> Could it be that you loaded older kernel by accident? Does anybody
> else still seeing "Spurios ACK" messages during kernel panic?

Well, no, I'm really on 2.6.20-rc2, from a freshly cloned tree. And I do 
get atkbd.c complaining at me when I boot with root=/dev/wrong-device.

Could you point me to the changeset in question? I couldn't find it 
searching for "leds" in the log.

Rene
