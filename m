Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262974AbUDUOps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbUDUOps (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 10:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbUDUOps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 10:45:48 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:13210 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S262974AbUDUOpp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 10:45:45 -0400
Date: Wed, 21 Apr 2004 16:45:23 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: s390 patches for 2.6.6-rc2.
Message-ID: <20040421144523.GA2951@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
another set of patches for s390 against 2.6.6-rc2. Seven bug fix and
three new function patches. The last patch might be controversial,
it's the timer patch that allows s390 to switch off the HZ timer
in idle. It has some common code hits but they are #ifdef'ed with
CONFIG_NO_IDLE_HZ. Without the config option there is no difference
in the generated code.

Descriptions:
1) s390 architecture fixes.
2) Common i/o layer fixes.
3) 3270 device driver fixes.
4) Network driver fixes.
5) Dasd driver fixes.
6) zfcp host adapter fixes.

7) Add oprofile support for s390.
8) Add support for z990 crypto instructions to in-kernel crypto api.
9) Add option to switch off the HZ timer in idle.

blue skies,
  Martin.

