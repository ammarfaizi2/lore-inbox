Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbUCaDhV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 22:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbUCaDhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 22:37:21 -0500
Received: from pri-dns.cs.iitm.ernet.in ([202.141.25.89]:12418 "EHLO
	cello.cs.iitm.ernet.in") by vger.kernel.org with ESMTP
	id S261712AbUCaDhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 22:37:16 -0500
To: linux-kernel@vger.kernel.org
Subject: alsamixer muting when restoring from suspend.
From: Rajsekar <rajsekar@peacock.iitm.ernet.in>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.2 (gnu/linux)
Date: Wed, 31 Mar 2004 08:27:42 +0530
Message-ID: <y49y8phn2op.fsf@sahana.cs.iitm.ernet.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This I think is not a problem but rather a subtle bug.

Alsamixer by default mutes all channels when loaded.
So when I `swsusp' my comp while I listen to music and restore the music
plays from where it left alright, but the channels are muted.
Is there a way to unmute them implicitly when restoring.

-- 
   M Rajsekar
   IIT Madras

