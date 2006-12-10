Return-Path: <linux-kernel-owner+w=401wt.eu-S1759126AbWLJMtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759126AbWLJMtw (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 07:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759143AbWLJMtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 07:49:52 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:33733 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759126AbWLJMtv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 07:49:51 -0500
X-Sasl-enc: T79ejBFfY5IdL+dD26QXpGz5thoyjjUEx7QaqvJi6M57 1165754990
Date: Sun, 10 Dec 2006 10:49:46 -0200
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       ibm-acpi-devel@lists.sourceforge.net
Subject: Re: [ibm-acpi-devel] [PATCH] Add Ultrabay support for the T60p Thinkpad
Message-ID: <20061210124945.GA23625@khazad-dum.debian.net>
References: <E1GtH0P-0007WV-Q5@candygram.thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1GtH0P-0007WV-Q5@candygram.thunk.org>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2006, Theodore Ts'o wrote:
> Add Ultrabay Support for the T60p Thinkpad

Thanks, an equivalent patch is alredy merged in acpi-test, and waiting a
push to linus.

BTW: this is an ACK if you want to merge this patch ahead of the stuff in
acpi-test.

> Ultrabay devices for the T60p Thinkpad; my guess is that it probably
> works on T60 Thinkpads and probably more recent Lenovo latops as well.

It works on all *60 and *61 new ThinkPads, yes.

> have the device appear again.  (With the 1.02 BIOS the device does not
> function when re-inserted, even after a warm boot; a cold reboot is
> required to store the Ultrabay device's functionality.)

Nice to know that, thanks.

Take a look on the experimental ACPI bay and dock support in acpi-test, it
is even better than ibm-acpi's builtin support... and in fact, deprecates
it.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
