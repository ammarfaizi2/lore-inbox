Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276803AbRJPWhB>; Tue, 16 Oct 2001 18:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276800AbRJPWgv>; Tue, 16 Oct 2001 18:36:51 -0400
Received: from hermes.domdv.de ([193.102.202.1]:49679 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S276803AbRJPWgp>;
	Tue, 16 Oct 2001 18:36:45 -0400
Message-ID: <XFMail.20011017003626.ast@domdv.de>
X-Mailer: XFMail 1.4.6-3 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Wed, 17 Oct 2001 00:36:26 +0200 (CEST)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.13pre2 missing EXPORT_SYMBOL(generic_direct_IO)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following line is required in kernel/ksyms.c for ext2 when ext2 is built as
a module.

EXPORT_SYMBOL(generic_direct_IO);


Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
