Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbTEUTcB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 15:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbTEUTcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 15:32:01 -0400
Received: from mstr195175-15286.dial-in.ttnet.net.tr ([195.175.139.183]:1540
	"EHLO alatau.radix50.net") by vger.kernel.org with ESMTP
	id S262228AbTEUTcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 15:32:00 -0400
Date: Wed, 21 May 2003 22:43:29 +0300
From: Baurjan Ismagulov <ibr@ata.cs.hun.edu.tr>
To: linux-kernel@vger.kernel.org
Subject: reducing ATA retry count
Message-ID: <20030521194329.GA734@alatau>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've got an ATA hard disk with bad sectors. I want to read the good
sectors quickly, replacing the others with zeroes. However, when I'm
trying to read it sector by sector, reading each bad sector takes 20-150
s. Before diving into the code, I'd like to ask whether there is an
interface (like ioctl or /proc) to disable bus resets and re-reading
attempts if the first read operation fails.

Please cc to me, I'm not subscribed.

Thanks in advance,
Baurjan.
