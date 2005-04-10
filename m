Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVDJPDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVDJPDx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 11:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVDJPDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 11:03:53 -0400
Received: from smtp.etmail.cz ([160.218.43.220]:45498 "EHLO smtp.etmail.cz")
	by vger.kernel.org with ESMTP id S261506AbVDJPDx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 11:03:53 -0400
From: "=?UTF-8?Q?Pavel_Machek?=" <pavel@ucw.cz>
To: <ast@domdv.de>, <pavel@suse.cz>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?Q?Re:[PATCH]_zero_disk_pages_used_by_swsusp_on_resume?=
Date: Sun, 10 Apr 2005 15:03:40 +0000
Message-Id: <1113145420344@pavel_ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: EMCL2 v3.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! What about doing it right? Encrypt it with symmetric cypher and store key in suspend header. That way key is removed automagically while fixing signatures. No need to clear anythink. OTOH we may want to dm-crypt whole swap partition. You could still store key in header... --p

-- pavel. Sent from  mobile phone. Sorry for poor formatting.
