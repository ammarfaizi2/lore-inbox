Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270404AbUJEQNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270404AbUJEQNS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 12:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270397AbUJEQNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 12:13:17 -0400
Received: from gw.anda.ru ([212.57.164.72]:49412 "EHLO mail.ward.six")
	by vger.kernel.org with ESMTP id S270389AbUJEQNG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 12:13:06 -0400
Date: Tue, 5 Oct 2004 22:12:58 +0600
From: Denis Zaitsev <zzz@anda.ru>
To: linux-kernel@vger.kernel.org
Subject: [2.6.8.1] Can't activate ISA PnP modem
Message-ID: <20041005221257.A9770@natasha.ward.six>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't activate my modem under this kernel.  Neither

        cat auto >/sys/bus/pnp/devices/.../resources

nor cat ... dynamic.  And it insn't activated at the start time, of
course.  After cat auto >resources the file contains state=disabled
and _correctly_ assigned IO ranges and IRQ.  Modem is USR Courier.
What all these mean?

Thanks in advance.
