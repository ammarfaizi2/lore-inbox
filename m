Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbUBYNi5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 08:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbUBYNi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 08:38:57 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:41163 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261322AbUBYNi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 08:38:56 -0500
Message-ID: <403CA56E.90403@helmutauer.de>
Date: Wed, 25 Feb 2004 14:38:54 +0100
From: Helmut Auer <vdr@helmutauer.de>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Change in compiler.h causes compile errors in many applications 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:dc795559fd1207bef82c0d6ee61125c0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
With kernel 2.6.3 a
#ifdef __KERNEL__
was added at the beginning of linux/compiler.h
That causes compile errors in severel applications, because the 
following includes were no longer done.
Was that caused by accident ?

-- 
Helmut Auer, helmut@helmutauer.de 

