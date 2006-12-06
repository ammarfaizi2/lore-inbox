Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760293AbWLFIWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760293AbWLFIWb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 03:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760296AbWLFIWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 03:22:31 -0500
Received: from wx-out-0506.google.com ([66.249.82.225]:2530 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760293AbWLFIWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 03:22:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ikOk1iI7m7DqB2X7+JpS37hkyX4mHMVNp2KAZ96oiFDo7HDbFJKONvj+VrGMv5MV8+eSlyKsMQxpptuXNPD5EV72v4P458wA6mjFOoJF+yFAZ2gMISb6545Skq9UXB+KY+PmHBbrUXbRIZz/iziBAeDgR92gdPIS4VlI725VApo=
Message-ID: <9a8748490612060022i25fc2617ya90e48c2e3c719d1@mail.gmail.com>
Date: Wed, 6 Dec 2006 09:22:29 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: vmscan.c:196: bad pmd (kernel 2.4.25)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following messages just showed up in dmesg on one of my servers.
The server seems to be running fine but I would like to know if
there's a real problem here or if the message is just noise.

The server is running 2.4.25

vmscan.c:196: bad pmd 000001e3.
vmscan.c:196: bad pmd 004001e3.
vmscan.c:196: bad pmd 008001e3.
vmscan.c:196: bad pmd 00c001e3.
vmscan.c:196: bad pmd 010001e3.
vmscan.c:196: bad pmd 014001e3.
vmscan.c:196: bad pmd 018001e3.
vmscan.c:196: bad pmd 01c001e3.
vmscan.c:196: bad pmd 020001e3.
vmscan.c:196: bad pmd 024001e3.
vmscan.c:196: bad pmd 028001e3.
vmscan.c:196: bad pmd 02c001e3.
vmscan.c:196: bad pmd 030001e3.
vmscan.c:196: bad pmd 034001e3.
vmscan.c:196: bad pmd 038001e3.
vmscan.c:196: bad pmd 03c001e3.
vmscan.c:196: bad pmd 040001e3.
vmscan.c:196: bad pmd 044001e3.
vmscan.c:196: bad pmd 048001e3.
vmscan.c:196: bad pmd 04c001e3.
vmscan.c:196: bad pmd 050001e3.
vmscan.c:196: bad pmd 054001e3.
vmscan.c:196: bad pmd 058001e3.
vmscan.c:196: bad pmd 05c001e3.
vmscan.c:196: bad pmd 060001e3.
vmscan.c:196: bad pmd 064001e3.
vmscan.c:196: bad pmd 068001e3.
vmscan.c:196: bad pmd 06c001e3.
vmscan.c:196: bad pmd 070001e3.
vmscan.c:196: bad pmd 074001e3.
vmscan.c:196: bad pmd 078001e3.
vmscan.c:196: bad pmd 07c001e3.
vmscan.c:196: bad pmd 080001e3.
vmscan.c:196: bad pmd 084001e3.
vmscan.c:196: bad pmd 088001e3.
vmscan.c:196: bad pmd 08c001e3.
vmscan.c:196: bad pmd 090001e3.
vmscan.c:196: bad pmd 094001e3.
vmscan.c:196: bad pmd 098001e3.
vmscan.c:196: bad pmd 09c001e3.
vmscan.c:196: bad pmd 0a0001e3.
vmscan.c:196: bad pmd 0a4001e3.
vmscan.c:196: bad pmd 0a8001e3.
vmscan.c:196: bad pmd 0ac001e3.
vmscan.c:196: bad pmd 0b0001e3.
vmscan.c:196: bad pmd 0b4001e3.
vmscan.c:196: bad pmd 0b8001e3.
vmscan.c:196: bad pmd 0bc001e3.
vmscan.c:196: bad pmd 0c0001e3.
vmscan.c:196: bad pmd 0c4001e3.
vmscan.c:196: bad pmd 0c8001e3.
vmscan.c:196: bad pmd 0cc001e3.
vmscan.c:196: bad pmd 0d0001e3.
vmscan.c:196: bad pmd 0d4001e3.
vmscan.c:196: bad pmd 0d8001e3.
vmscan.c:196: bad pmd 0dc001e3.
vmscan.c:196: bad pmd 0e0001e3.
vmscan.c:196: bad pmd 0e4001e3.
vmscan.c:196: bad pmd 0e8001e3.
vmscan.c:196: bad pmd 0ec001e3.
vmscan.c:196: bad pmd 0f0001e3.
vmscan.c:196: bad pmd 0f4001e3.
vmscan.c:196: bad pmd 0f8001e3.
vmscan.c:196: bad pmd 0fc001e3.
vmscan.c:196: bad pmd 100001e3.
vmscan.c:196: bad pmd 104001e3.
vmscan.c:196: bad pmd 108001e3.
vmscan.c:196: bad pmd 10c001e3.
vmscan.c:196: bad pmd 110001e3.
vmscan.c:196: bad pmd 114001e3.
vmscan.c:196: bad pmd 118001e3.
vmscan.c:196: bad pmd 11c001e3.
vmscan.c:196: bad pmd 120001e3.
vmscan.c:196: bad pmd 124001e3.
vmscan.c:196: bad pmd 128001e3.
vmscan.c:196: bad pmd 12c001e3.
vmscan.c:196: bad pmd 130001e3.
vmscan.c:196: bad pmd 134001e3.
vmscan.c:196: bad pmd 138001e3.
vmscan.c:196: bad pmd 13c001e3.
vmscan.c:196: bad pmd 140001e3.
vmscan.c:196: bad pmd 144001e3.
vmscan.c:196: bad pmd 148001e3.
vmscan.c:196: bad pmd 14c001e3.
vmscan.c:196: bad pmd 150001e3.
vmscan.c:196: bad pmd 154001e3.
vmscan.c:196: bad pmd 158001e3.
vmscan.c:196: bad pmd 15c001e3.
vmscan.c:196: bad pmd 160001e3.
vmscan.c:196: bad pmd 164001e3.
vmscan.c:196: bad pmd 168001e3.
vmscan.c:196: bad pmd 16c001e3.
vmscan.c:196: bad pmd 170001e3.
vmscan.c:196: bad pmd 174001e3.
vmscan.c:196: bad pmd 178001e3.
vmscan.c:196: bad pmd 17c001e3.
vmscan.c:196: bad pmd 180001e3.
vmscan.c:196: bad pmd 184001e3.
vmscan.c:196: bad pmd 188001e3.
vmscan.c:196: bad pmd 18c001e3.
vmscan.c:196: bad pmd 190001e3.
vmscan.c:196: bad pmd 194001e3.
vmscan.c:196: bad pmd 198001e3.
vmscan.c:196: bad pmd 19c001e3.
vmscan.c:196: bad pmd 1a0001e3.
vmscan.c:196: bad pmd 1a4001e3.
vmscan.c:196: bad pmd 1a8001e3.
vmscan.c:196: bad pmd 1ac001e3.
vmscan.c:196: bad pmd 1b0001e3.
vmscan.c:196: bad pmd 1b4001e3.
vmscan.c:196: bad pmd 1b8001e3.
vmscan.c:196: bad pmd 1bc001e3.
vmscan.c:196: bad pmd 1c0001e3.
vmscan.c:196: bad pmd 1c4001e3.
vmscan.c:196: bad pmd 1c8001e3.
vmscan.c:196: bad pmd 1cc001e3.
vmscan.c:196: bad pmd 1d0001e3.
vmscan.c:196: bad pmd 1d4001e3.
vmscan.c:196: bad pmd 1d8001e3.
vmscan.c:196: bad pmd 1dc001e3.
vmscan.c:196: bad pmd 1e0001e3.
vmscan.c:196: bad pmd 1e4001e3.
vmscan.c:196: bad pmd 1e8001e3.
vmscan.c:196: bad pmd 1ec001e3.
vmscan.c:196: bad pmd 1f0001e3.
vmscan.c:196: bad pmd 1f4001e3.
vmscan.c:196: bad pmd 1f8001e3.
vmscan.c:196: bad pmd 1fc001e3.
vmscan.c:196: bad pmd 200001e3.
vmscan.c:196: bad pmd 204001e3.
vmscan.c:196: bad pmd 208001e3.
vmscan.c:196: bad pmd 20c001e3.
vmscan.c:196: bad pmd 210001e3.
vmscan.c:196: bad pmd 214001e3.
vmscan.c:196: bad pmd 218001e3.
vmscan.c:196: bad pmd 21c001e3.
vmscan.c:196: bad pmd 220001e3.
vmscan.c:196: bad pmd 224001e3.
vmscan.c:196: bad pmd 228001e3.
vmscan.c:196: bad pmd 22c001e3.
vmscan.c:196: bad pmd 230001e3.
vmscan.c:196: bad pmd 234001e3.
vmscan.c:196: bad pmd 238001e3.
vmscan.c:196: bad pmd 23c001e3.
vmscan.c:196: bad pmd 240001e3.
vmscan.c:196: bad pmd 244001e3.
vmscan.c:196: bad pmd 248001e3.
vmscan.c:196: bad pmd 24c001e3.
vmscan.c:196: bad pmd 250001e3.
vmscan.c:196: bad pmd 254001e3.
vmscan.c:196: bad pmd 258001e3.
vmscan.c:196: bad pmd 25c001e3.
vmscan.c:196: bad pmd 260001e3.
vmscan.c:196: bad pmd 264001e3.
vmscan.c:196: bad pmd 268001e3.
vmscan.c:196: bad pmd 26c001e3.
vmscan.c:196: bad pmd 270001e3.
vmscan.c:196: bad pmd 274001e3.
vmscan.c:196: bad pmd 278001e3.
vmscan.c:196: bad pmd 27c001e3.
vmscan.c:196: bad pmd 280001e3.
vmscan.c:196: bad pmd 284001e3.
vmscan.c:196: bad pmd 288001e3.
vmscan.c:196: bad pmd 28c001e3.
vmscan.c:196: bad pmd 290001e3.
vmscan.c:196: bad pmd 294001e3.
vmscan.c:196: bad pmd 298001e3.
vmscan.c:196: bad pmd 29c001e3.
vmscan.c:196: bad pmd 2a0001e3.
vmscan.c:196: bad pmd 2a4001e3.
vmscan.c:196: bad pmd 2a8001e3.
vmscan.c:196: bad pmd 2ac001e3.
vmscan.c:196: bad pmd 2b0001e3.
vmscan.c:196: bad pmd 2b4001e3.
vmscan.c:196: bad pmd 2b8001e3.
vmscan.c:196: bad pmd 2bc001e3.
vmscan.c:196: bad pmd 2c0001e3.
vmscan.c:196: bad pmd 2c4001e3.
vmscan.c:196: bad pmd 2c8001e3.
vmscan.c:196: bad pmd 2cc001e3.
vmscan.c:196: bad pmd 2d0001e3.
vmscan.c:196: bad pmd 2d4001e3.
vmscan.c:196: bad pmd 2d8001e3.
vmscan.c:196: bad pmd 2dc001e3.
vmscan.c:196: bad pmd 2e0001e3.
vmscan.c:196: bad pmd 2e4001e3.
vmscan.c:196: bad pmd 2e8001e3.
vmscan.c:196: bad pmd 2ec001e3.
vmscan.c:196: bad pmd 2f0001e3.
vmscan.c:196: bad pmd 2f4001e3.
vmscan.c:196: bad pmd 2f8001e3.
vmscan.c:196: bad pmd 2fc001e3.
vmscan.c:196: bad pmd 300001e3.
vmscan.c:196: bad pmd 304001e3.
vmscan.c:196: bad pmd 308001e3.
vmscan.c:196: bad pmd 30c001e3.
vmscan.c:196: bad pmd 310001e3.
vmscan.c:196: bad pmd 314001e3.
vmscan.c:196: bad pmd 318001e3.
vmscan.c:196: bad pmd 31c001e3.
vmscan.c:196: bad pmd 320001e3.
vmscan.c:196: bad pmd 324001e3.
vmscan.c:196: bad pmd 328001e3.
vmscan.c:196: bad pmd 32c001e3.
vmscan.c:196: bad pmd 330001e3.
vmscan.c:196: bad pmd 334001e3.
vmscan.c:196: bad pmd 338001e3.
vmscan.c:196: bad pmd 33c001e3.
vmscan.c:196: bad pmd 340001e3.
vmscan.c:196: bad pmd 344001e3.
vmscan.c:196: bad pmd 348001e3.
vmscan.c:196: bad pmd 34c001e3.
vmscan.c:196: bad pmd 350001e3.
vmscan.c:196: bad pmd 354001e3.
vmscan.c:196: bad pmd 358001e3.
vmscan.c:196: bad pmd 35c001e3.
vmscan.c:196: bad pmd 360001e3.
vmscan.c:196: bad pmd 364001e3.
vmscan.c:196: bad pmd 368001e3.
vmscan.c:196: bad pmd 36c001e3.
vmscan.c:196: bad pmd 370001e3.
vmscan.c:196: bad pmd 374001e3.
vmscan.c:196: bad pmd 378001e3.
vmscan.c:196: bad pmd 37c001e3.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
