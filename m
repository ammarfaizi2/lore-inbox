Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316668AbSGYXpe>; Thu, 25 Jul 2002 19:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316672AbSGYXpe>; Thu, 25 Jul 2002 19:45:34 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:20204 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316668AbSGYXpd>; Thu, 25 Jul 2002 19:45:33 -0400
Date: Fri, 26 Jul 2002 01:48:41 +0200
From: axel@hh59.org
To: linux-kernel@vger.kernel.org
Cc: kkeil@suse.de, kai.germaschewski@gmx.de
Subject: 2.5.28: depmod: *** Unresolved symbols in dss1_divert.o, isdnloop.o
Message-ID: <20020725234841.GA18222@neon.hh59.org>
Mail-Followup-To: linux-kernel@vger.kernel.org, kkeil@suse.de,
	kai.germaschewski@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: hh59.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just built 2.5.28 and here are unresolved symbols in the above modules..

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.28; fi
depmod: *** Unresolved symbols in
/lib/modules/2.5.28/kernel/drivers/isdn/divert/dss1_divert.o
depmod:         cli
depmod:         restore_flags
depmod:         save_flags
depmod: *** Unresolved symbols in
/lib/modules/2.5.28/kernel/drivers/isdn/isdnloop/isdnloop.o
depmod:         cli
depmod:         restore_flags
depmod:         save_flags
make: *** [_modinst_post] Error 1

Regards,
Axel
