Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbUD1Tey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbUD1Tey (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 15:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUD1TeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:34:22 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:19653 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S264948AbUD1QtE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 12:49:04 -0400
Date: Wed, 28 Apr 2004 18:48:53 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: s390 patches for 2.6.6-rc3.
Message-ID: <20040428164853.GA2777@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
the timer patch made it to BitKeeper! That is very nice, the patch
has been around for quite a long time. Now only the oprofile patch
and the xip2fs question needs to be resolved and I'm a really happy
camper :-)
The oprofile code should be fine now, I added all suggestion I got
from the mailing list and Arnd double checked it. The other 5
patches are continuous bug fixes.

Descriptions:
1) s390 core changes.
2) Common i/o layer fixes. The new single threaded workqueues are
   nice for the cio layer.
3) Network driver fixes.
4) 3270 console driver fix.
5) zfcp host adapter fix.

6) Add oprofile support for s390.

blue skies,
  Martin.

