Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265484AbUGDIoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265484AbUGDIoU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 04:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265487AbUGDIoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 04:44:20 -0400
Received: from tag.witbe.net ([81.88.96.48]:64960 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S265484AbUGDIoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 04:44:19 -0400
Message-Id: <200407040844.i648iGX08954@tag.witbe.net>
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: "'Milton Miller'" <miltonm@bga.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Init single and Serial console : How to ?
Date: Sun, 4 Jul 2004 10:44:12 +0200
Organization: AS2917
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <69CB182A-CD80-11D8-9463-003065DC03B0@bga.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcRhjVuzRXfSNJIcTXmDxEmE4pNeFQAFYrpA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Milton,
> 
> Not quite single mode, but what I have done in similar situations is 
> boot with
> console=ttyS0 init=/bin/sh

Should do the trick. Single mode was good because it was not running
rl 3 init-scripts.
Not running any of them is good too :-)
The trick was to have the serial console/shell without having to
go thru the ioctlsave stuff.


Regards,
Paul

