Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbUC3GnN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 01:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbUC3Gmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 01:42:42 -0500
Received: from quechua.inka.de ([193.197.184.2]:57065 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S262932AbUC3GmK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 01:42:10 -0500
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: [Swsusp-devel] [PATCH 2.6]: suspend to disk only available if non-modular IDE
Date: Mon, 29 Mar 2004 23:34:46 +0200
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Message-Id: <pan.2004.03.29.21.34.45.973137@dungeon.inka.de>
References: <200403282136.55435.arekm@pld-linux.org> <1080517040.2223.3.camel@laptop-linux.wpcb.org.au> <1080517591.5047.10.camel@laptop-linux.wpcb.org.au>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

so suspend to disk does not work with scsi?

>> > -       depends on PM && SWAP
>> > +       depends on PM && SWAP && IDE=y && BLK_DEV_IDEDISK=y

implies IDE is needed.

btw: would it be somehow possible to resume after initrd phase?
or some other idea how a generic kernel with modules in the initrd
could use suspend to disk? or a laptop where the initrd is needed
to setup a dm-crypt volume with the right decrypton key?

Regards, Andreas

