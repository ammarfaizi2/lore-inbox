Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWE2Fbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWE2Fbp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 01:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWE2Fbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 01:31:44 -0400
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:16754 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751203AbWE2Fbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 01:31:44 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: "LKML, " <linux-kernel@vger.kernel.org>
Subject: Should we make dmi_check_system case insensitive?
Date: Mon, 29 May 2006 01:31:41 -0400
User-Agent: KMail/1.9.1
Cc: Vojtech Pavlik <vojtech@suse.cz>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Andi Kleen <ak@muc.de>, Andrey Panin <pazke@orbita1.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605290131.42292.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a request to add entry for "LifeBook B Series" to lifebook driver to
accomodate lifebook B2545, however we already have entry for "LIFEBOOK B
Series" (used by some other model) which is not working. Would anyone
be opposed making dmi_check_system() ignore string case? We would have to
malloc/copy both strings and lowercase them before doing stsstr...   

-- 
Dmitry
