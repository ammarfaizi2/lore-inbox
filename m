Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264855AbUASLe4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 06:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264575AbUASLeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 06:34:17 -0500
Received: from mout1.freenet.de ([194.97.50.132]:33959 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S264594AbUASLcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 06:32:41 -0500
From: Andreas Hartmann <andihartmann@freenet.de>
X-Newsgroups: fa.linux.kernel
Subject: Re: TG3: very high CPU usage
Date: Mon, 19 Jan 2004 12:32:24 +0100
Organization: privat
Message-ID: <bugf88$932$1@A8bba.a.pppool.de>
References: <fa.eu7l1gd.ekqe1j@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: abuse@fu.berlin.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: de, en-us, en
In-Reply-To: <fa.eu7l1gd.ekqe1j@ifi.uio.no>
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Williams (MWP) wrote:
[...]
> However, when using Apache or any FTP client/daemon, the TG3 driver appears to be VERY slow maxing out CPU usage at 100% while only transfering at around 12MB/sec.
> This applies for both incoming or outgoing data.

[...]

> Ive tried other NICs, etc and confirmed that it is a problem with the TG3 driver.

I saw the same problem with the bcm-driver (Kernel 2.4.x) shipped with
SuSE 9 / SLES 8. Testcase was the initial mirror of a 10 GB partition on a
raid5 serveraid / XSeries 235 (2 way) to the same hardware on the remote
machine using both times the onboard NIC (Broadcom GBit Ethernet) via drbd:
100% CPU usage, 12 MB/s, machine is nearly death.


Regards,
Andreas Hartmann
