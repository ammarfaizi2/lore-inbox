Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbUAFNuz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 08:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264353AbUAFNuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 08:50:54 -0500
Received: from AMontpellier-205-2-1-77.w193-252.abo.wanadoo.fr ([193.252.48.77]:1785
	"EHLO tethys.montpellier.4js.com") by vger.kernel.org with ESMTP
	id S262925AbUAFNux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 08:50:53 -0500
Date: Tue, 6 Jan 2004 15:51:02 +0100
From: wwp <subscript@free.fr>
To: linux-kernel@vger.kernel.org
Subject: ext3 corruption w/ kernels > 2.4.19
Message-Id: <20040106155102.24118e6c@tethys>
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

using a Dell Inspiron 8200 and a SuSE 8.1, I encounter ext3 fs data losses.
Some directories are often corrupted and I need to fsck manually when I found
some missing or altered files.
It seems that only a small set of possible directories are concerned (a limited
range of inodes).

I only get such fs corruption using vanilla kernel 2.4.21-23, when I reboot or
shutdown the machine. I could not figure out if the corruption occurs ar shutdown
or startup :-\. Scanning the harddisk for bad blocks never returned positive
results and ysing the SuSE's default 2.4.19, I never encounter such problems.

Does anyone have an idea of where is the problem, or where I could look
for or what kind of information I could report?


Regards,

-- 
wwp
