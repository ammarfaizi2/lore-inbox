Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265375AbUAMUfI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 15:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265377AbUAMUfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 15:35:08 -0500
Received: from [212.28.208.94] ([212.28.208.94]:54537 "HELO dewire.com")
	by vger.kernel.org with SMTP id S265375AbUAMUfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 15:35:06 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Autofs question
Date: Tue, 13 Jan 2004 21:35:02 +0100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200401132135.03001.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I grabbed the auto.smb skript for mounting samba/windows shared. One of the flaws is that I'd
like to get around is that it must be configured as root and most importantly that I don't see who 
is requesting the mount. I was thinking along the line of mounting shares in /cifs/$USER/servers/share.

the auto.smb script is running as root and I printed some info in root.c at the revalidate

