Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbUKIRSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbUKIRSs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 12:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbUKIRSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 12:18:48 -0500
Received: from pop.gmx.de ([213.165.64.20]:39319 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261588AbUKIRSr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 12:18:47 -0500
X-Authenticated: #21910825
Message-ID: <4190FBF2.5020604@gmx.net>
Date: Tue, 09 Nov 2004 18:18:42 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6) Gecko/20040114
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Kevin Corry <kevcorry@us.ibm.com>
Subject: dynamic block minor registration
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

in my quest for a unified /dev/disk I found some code in device-mapper
which seems to handle dynamic block minor registration. Are there any
plans to move that code out of device-mapper and make it available for
all block device drivers?

IIRC there was also a limitation that one block major could not be
shared between different drivers, even if the minor ranges they wanted
didn't overlap. Is this still the case?

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
