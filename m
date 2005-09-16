Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161136AbVIPIwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161136AbVIPIwJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 04:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161137AbVIPIwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 04:52:09 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:53421 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S1161136AbVIPIwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 04:52:08 -0400
Message-ID: <432A874F.7040806@cs.aau.dk>
Date: Fri, 16 Sep 2005 10:50:23 +0200
From: Emmanuel Fleury <fleury@cs.aau.dk>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Automatic Configuration of a Kernel
References: <20050916083200.28972.qmail@web51010.mail.yahoo.com>
In-Reply-To: <20050916083200.28972.qmail@web51010.mail.yahoo.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahmad, as far as I understood, your spirit is more or less to:

- Drop automagically all the hardware which is for sure NOT here
- Propose to the user to include the hardware which is detected
- Leave as default the rest of the choices
  (i.e. the choices that might be uncertain: fs, protocols, ...)

Therefore, "make autoconfig" is a quick first run through the .config
with the help of all the scripts stored in scripts/autoconfig/.

Regards
-- 
Emmanuel Fleury

Step #1 in programming: understand people.
  -- Linus Torvalds
