Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbULFWH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbULFWH2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 17:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbULFWH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 17:07:28 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:60711 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261675AbULFWHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 17:07:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=Gti/u0X6um3tnbyl47XtSK+0ciSr6Gn5xYtF/heHxkSjU0VzT+Tz2LAymjF1uXARVzKWYgYNFme9mQOc0X+XZ8E2cRMLROJ9aWQKwnL91GjzNUlkzxtl1Z01XASjUW2+7B/7fI3VM37f5MaCETxzu0j83EE4DUgb+pymbjTQulk=
Message-ID: <8e93903b041206140529a8baa9@mail.gmail.com>
Date: Mon, 6 Dec 2004 22:05:58 +0000
From: Alan Pope <alan.pope@gmail.com>
Reply-To: Alan Pope <alan.pope@gmail.com>
To: linux-kernel@vger.kernel.org, bugs@linux-ide.org, andre@linux-ide.org
Subject: PDC202XX_OLD broken
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added a "Seagate ST3200822A Barracuda 7200.7 Plus 200GB" disk to my
main PC which uses a with "Promise PDC20265 (FastTrak100
Lite/Ultra100) (rev 02)" controller.

I get these when placing the disk under any load (DMA enabled)

hde: dma_intr: status=0xff { Busy }

ide: failed opcode was: unknown
hde: DMA disabled
PDC202XX: Primary channel reset.
PDC202XX: Secondary channel reset.

(a number of times)

ide2: reset timed-out, status=0xff
end_request: I/O error, dev hde, sector 11776
Buffer I/O error on device hde, logical block 1472

(many times)

Any clues, greatfully received.

I've tried under 2.6.8 through 2.6.9-ac9 & 2.6.10-rc2 with the same effect.

Thanks,
Al.
