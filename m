Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbUBXHaU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 02:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbUBXHaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 02:30:20 -0500
Received: from bambu.metla.fi ([128.214.53.7]:48011 "EHLO bambu.metla.fi")
	by vger.kernel.org with ESMTP id S262194AbUBXHaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 02:30:16 -0500
Date: Tue, 24 Feb 2004 09:30:01 +0200 (EET)
From: Kai Makisara <Kai.Makisara@metla.fi>
To: Linus Torvalds <torvalds@osdl.org>,
       James Bottomley <James.Bottomley@SteelEye.com>
cc: Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, kai.makisara@kolumbus.fi
Subject: Re: [BK PATCH] SCSI update for 2.6.3
Message-ID: <Pine.LNX.4.58.0402240919490.1129@spektro.metla.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Feb 2004, Linus Torvalds wrote:
>On Mon, 23 Feb 2004, James Bottomley wrote:
>>
>> Kai Mäkisara:
>> o Sysfs class support for SCSI tapes
>
>Has this been checked for correctness, or will Al flame me to a crisp for
>accepting it? Pls verify..

It is using the class_simple interface Greg KH said can be used without
changes to driver's lifetime rules. If this is not true, then I have to
rework the patch. The code was posted to linux-scsi on Feb 5 but I would
not count on any serious review being done there.

	Kai
