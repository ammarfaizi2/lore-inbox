Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262117AbVBJOKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbVBJOKs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 09:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbVBJOKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 09:10:48 -0500
Received: from pop.gmx.net ([213.165.64.20]:53973 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262117AbVBJOKo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 09:10:44 -0500
X-Authenticated: #26200865
Message-ID: <420B6BA8.1040808@gmx.net>
Date: Thu, 10 Feb 2005 15:11:52 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.2) Gecko/20040906
X-Accept-Language: de, en
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: EDD failures since edd=off patch
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

it seems the edd=off patch has caused some problems with
some machines I have access to. They simply don't boot
anymore unless I specify edd=foo. foo can be {off,skip,bar}
so it seems the hang on boot is related to the parser
not finding the parameter it is looking for.
I looked through the code some days ago and it seemed to
me that the register used to iterate through the command
line buffer only got its lower 16 bit reset before calling
into the BIOS. I don't have the code handy right now,
but I can look later if the hints I gave are insufficient.

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
