Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265978AbUJLPan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265978AbUJLPan (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 11:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265971AbUJLPam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 11:30:42 -0400
Received: from gate.corvil.net ([213.94.219.177]:13070 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S265978AbUJLPab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 11:30:31 -0400
Message-ID: <416BF891.9080806@draigBrady.com>
Date: Tue, 12 Oct 2004 16:30:25 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: No mtime updates for loopback mounted filesystems
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed recently that files mounted loopback
do not have their mtimes updated if any writes are
done to the filesystem. In addition, files within
the loopback mounted filesystem do not have their
mtime updated if changed.

Pádraig.
