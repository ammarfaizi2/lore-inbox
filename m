Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVCTOfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVCTOfs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 09:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVCTOfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 09:35:48 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:48079 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261221AbVCTOfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 09:35:44 -0500
Message-ID: <423D8A3D.9090602@g-house.de>
Date: Sun, 20 Mar 2005 15:35:41 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050212)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Mauricio Lin <mauriciolin@gmail.com>, elenstev@mesatop.com,
       coywolf@gmail.com, Andrew Morton <akpm@osdl.org>
Subject: [SOLVED] Re: oom with 2.6.11
References: <422DC2F1.7020802@g-house.de>	 <3f250c710503090518526d8b90@mail.gmail.com>	 <3f250c7105030905415cab5192@mail.gmail.com>	 <422F016A.2090107@g-house.de> <423063DB.40905@g-house.de>	 <3f250c7105031101016d7cb08e@mail.gmail.com>	 <4231B4A4.4050207@g-house.de> <3f250c7105031500527007a0e7@mail.gmail.com> <4236ED5F.9020301@g-house.de>
In-Reply-To: <4236ED5F.9020301@g-house.de>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

for the record: the "oom bug" turned out to be user generated. a *lot* of
small scripts were started, triggering oom again and again, user error.

the source of the problem is still pppd and the discussion continues as a
debian bugreport:

    http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=299875

thank you for all your help,
Christian.
-- 
BOFH excuse #139:

UBNC (user brain not connected)
