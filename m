Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265497AbTGCWwX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 18:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265494AbTGCWwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 18:52:11 -0400
Received: from hera.cwi.nl ([192.16.191.8]:45002 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S265488AbTGCWvz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 18:51:55 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 4 Jul 2003 01:06:17 +0200 (MEST)
Message-Id: <UTC200307032306.h63N6HQ26283.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       torvalds@osdl.org
Subject: scsi mode sense broken again
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For me 2.5.72 works, 2.5.74 does not - no working ZIP drive.
The cause is the recent fiddling of use_10 / do_mode_sense.
If this is known and has a patch on the way all is well.
Otherwise I can send a patch.

Andries

(It feels as if I have to repair this area every other month.)

