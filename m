Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292968AbSCIWW0>; Sat, 9 Mar 2002 17:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292970AbSCIWWP>; Sat, 9 Mar 2002 17:22:15 -0500
Received: from smtp02.web.de ([217.72.192.151]:14363 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S292968AbSCIWV6>;
	Sat, 9 Mar 2002 17:21:58 -0500
Message-ID: <3C8A8AF6.3080002@web.de>
Date: Sat, 09 Mar 2002 23:21:42 +0100
From: Stephan Wienczny <wienczny@web.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de-AT; rv:0.9.8) Gecko/20020204
X-Accept-Language: de-de, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Video Module doesn't compile
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo!

The 2.5.5 Version of fbdev.c in the video/riva directory can not be 
compiled, because there is an error.

In the file fbdev.c in line 1815 is an type error. The typedef of kdev_t 
has changed but the line
info->node = -1;
did not.
The line had to be
info->node.value = -1;
to be compiled.

Stephan





