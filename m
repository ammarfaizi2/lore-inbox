Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272218AbRH3Nu0>; Thu, 30 Aug 2001 09:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272219AbRH3NuR>; Thu, 30 Aug 2001 09:50:17 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:41233 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S272218AbRH3NuE>; Thu, 30 Aug 2001 09:50:04 -0400
Message-ID: <3B8E44C0.6B5DD4A@loewe-komp.de>
Date: Thu, 30 Aug 2001 15:50:56 +0200
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.9-ac3 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.4.9-ac3 kpnpbios gets zombie
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IIRC Andrew Morton had fixed that with
a proper daemonize.
Am I wrong or did this bug crept in again?

USER    PID     STAT START   TIME COMMAND
root      1     S    13:23   0:04 init [
root      2     Z    13:23   0:01 [kpnpbios <defunct>
