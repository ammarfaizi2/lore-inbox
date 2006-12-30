Return-Path: <linux-kernel-owner+w=401wt.eu-S1754283AbWL3JWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754283AbWL3JWr (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 04:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754292AbWL3JWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 04:22:47 -0500
Received: from zone4.gcu.info ([217.195.17.234]:52997 "EHLO
	zone4.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754280AbWL3JWq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 04:22:46 -0500
Date: Sat, 30 Dec 2006 10:11:27 +0100 (CET)
To: vapier.adi@gmail.com, akpm@osdl.org
Subject: Re: [patch] fix typo in i2c smbus documentation
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <1SnUbvbt.1167469887.0687500.khali@localhost>
In-Reply-To: <8bd0f97a0612272039l15fb2484v8ebbc1065adab9e2@mail.gmail.com>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: i2c@lm-sensors.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Mike,

On 12/28/2006, Mike Frysinger wrote:
> the i2c smbus documentation has a typo ... when it describes the
> "SMBus Write Word Data" function, it says that it is meant to "read
> from a device" when in reality it should obviously be writing to the
> device

Good catch, applied, thanks. I've also backported this fix to i2c-SVN
and linux-2.4, as they also had the mistake.

> btw, the i2c/smbus docs in Documentation/i2c/ are superb, thanks all :)

You're welcome :)

--
Jean Delvare
