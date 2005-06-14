Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVFNLVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVFNLVq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 07:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVFNLVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 07:21:45 -0400
Received: from gate.corvil.net ([213.94.219.177]:41736 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S261186AbVFNLVp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 07:21:45 -0400
Message-ID: <42AEBDC4.2050907@draigBrady.com>
Date: Tue, 14 Jun 2005 12:21:40 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: optimal file order for reading from disk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know this will be dependent on filesystem, I/O scheduler, ...
but given a list of files, what is the best (filesystem
agnostic) order to read from disk (to minimise seeks).

Should I sort by path, inode number, getdents, or something else?

thanks,
Pádraig.
