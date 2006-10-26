Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423510AbWJZSAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423510AbWJZSAP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 14:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161401AbWJZSAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 14:00:15 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:9152 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1161387AbWJZSAN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 14:00:13 -0400
Message-ID: <4540F79C.7070705@gmail.com>
Date: Thu, 26 Oct 2006 19:59:56 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: removing drivers and ISA support? [Was: Char: correct pci_get_device
 changes]
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Sul, 2006-10-15 am 01:36 +0200, ysgrifennodd Jiri Slaby:
> > It affects moxa and rio char drivers. (All this stuff deserves to be
> > converted to pci_probing, though.)
>
> Agreed, or dropped

Alan, do you consider some (char) driver to be removed now?

And what about (E)ISA support. When converting to pci probing, should be ISA bus
support preserved (how much is ISA used in present)? -- it makes code ugly and long.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E

