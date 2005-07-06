Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbVGFFUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbVGFFUZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 01:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262087AbVGFFUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 01:20:24 -0400
Received: from [213.184.187.37] ([213.184.187.37]:42756 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S261689AbVGFD2W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 23:28:22 -0400
Message-Id: <200507060326.GAA25248@raad.intranet>
From: "Al Boldi" <a1426z@gawab.com>
To: "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Grant Coady'" <grant_lkml@dodo.com.au>
Cc: "'Jens Axboe'" <axboe@suse.de>,
       "'Ondrej Zary'" <linux@rainbow-software.org>,
       "=?windows-1256?Q?'Andr=E9_Tomt'?=" <andre@tomt.net>,
       "'Bartlomiej Zolnierkiewicz'" <bzolnier@gmail.com>,
       <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [git patches] IDE update
Date: Wed, 6 Jul 2005 06:26:03 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1256"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <Pine.LNX.4.58.0507051748540.3570@g5.osdl.org>
Thread-Index: AcWBxGnjRVIkuePeQnCOyjecro3VlgAFRGIg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote: {
On Wed, 6 Jul 2005, Grant Coady wrote:
> 
> Executive Summary

Btw, can you try this same thing (or at least a subset) with a large file on
a filesystem? Does that show the same pattern, or is it always just the raw
device?
}

Linus,
Cat /dev/hda > /dev/null and cat /tmp/tst.dsk > /dev/null show the same
symptoms.
The problem shows most when the cpu is slow and the hd is fast.
When the cpu is fast and the hd is slow the cpu will make up for lost cycles
and the problem will not show!


