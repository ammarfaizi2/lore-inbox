Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270097AbTG1Ptj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 11:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270185AbTG1Ptj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 11:49:39 -0400
Received: from postman1.arcor-online.net ([151.189.0.187]:37317 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S270097AbTG1Pti
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 11:49:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Johannes Ahlmann <softpro@gmx.net>
Reply-To: ahljoh@uni.de
To: linux-kernel@vger.kernel.org
Subject: hdparm IDE sleep mode
Date: Mon, 28 Jul 2003 18:04:14 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030728160412.98F59372@mendocino>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

man hdparm says:

"-Y
 Force  an  IDE  drive to immediately enter the lowest power con-
 sumption sleep mode, causing it to shut down completely.  A hard
 or soft reset is required before the drive can be accessed again
 (the Linux IDE driver will automatically handle issuing a  reset
 if/when  needed)."

but when i put my hdd in "sleep mode" (not suspend, that works fine) it 
shuts dowm properly but can not be woken up again... when shutting down the 
system, it hangs waiting for the hdds to come up again, but they never do...

i'm using kernel 2.4.20, IDE drives on a debian testing system.
any suggestions why the ide driver does not soft-reset the drives as 
implied in the hdparm man-page?

Johannes
