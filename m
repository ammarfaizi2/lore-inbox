Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbVJKMan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbVJKMan (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 08:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbVJKMan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 08:30:43 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:54157 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S932079AbVJKMam
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 08:30:42 -0400
From: Vincent Roqueta <vincent.roqueta@ext.bull.net>
Organization: BULL SA
To: linux-kernel@vger.kernel.org
Subject: linux 2.6.13.3+ext3: journal block not found
Date: Tue, 11 Oct 2005 14:33:56 +0200
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Message-Id: <200510111433.56067.vincent.roqueta@ext.bull.net>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 11/10/2005 14:44:16,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 11/10/2005 14:44:18,
	Serialize complete at 11/10/2005 14:44:18
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
  charset="us-ascii"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I use ext3 a laptop. The only disk intensive application I run is amule.
 After a (short) while running it, the /home filesystem is remounted readonly.

 Here are the traces I get :
Oct 11 08:17:39 localhost kernel: journal_bmap: journal block not found at 
offset 6156 on hda6
Oct 11 08:17:39 localhost kernel: Aborting journal on device hda6.
Oct 11 08:17:39 localhost kernel: __journal_remove_journal_head: freeing 
b_committed_data
Oct 11 08:17:39 localhost last message repeated 2 times
Oct 11 08:17:39 localhost kernel: journal commit I/O error
Oct 11 08:17:39 localhost kernel: ext3_abort called.
Oct 11 08:17:39 localhost kernel: EXT3-fs error (device hda6): 
ext3_journal_start_sb: Detected aborted journal
Oct 11 08:17:39 localhost kernel: Remounting filesystem read-only       

Kernel is linux 2.6.13.3
FS is ext3.

Vincent
