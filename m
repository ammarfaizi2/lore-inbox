Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262523AbVAPONO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262523AbVAPONO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 09:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262517AbVAPOMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 09:12:18 -0500
Received: from main.uucpssh.org ([212.27.33.224]:53959 "EHLO main.uucpssh.org")
	by vger.kernel.org with ESMTP id S262509AbVAPOGX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 09:06:23 -0500
To: Daniel Kirsten <kirsten@math.tu-dresden.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm1  waiting-10s-before-mounting-root-....
References: <572.1105705748@www33.gmx.net>
	<20050114233020.GA2181@samarkand.rivenstone.net>
	<200501151422.49319.kirsten@math.tu-dresden.de>
From: syrius.ml@no-log.org
Message-ID: <87vf9x32bi.87u0ph32bi@87sm5132bi.message.id>
Date: Sun, 16 Jan 2005 15:02:41 +0100
In-Reply-To: <200501151422.49319.kirsten@math.tu-dresden.de> (Daniel
 Kirsten's message of "Sat, 15 Jan 2005 14:22:49 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Kirsten <kirsten@math.tu-dresden.de> writes:

>>     Are you using an initrd?
> yes.

Then read Documentation/initrd.txt ...
Your initrd must be deprecated, i guess you have to use
root=/dev/whatever/your_final_root_fs with it while it should be
root=/dev/ram0. (pretty sure it doesn't use pivot_root either :) )

FYI it works here with an updated initrd without reversing a patch...

-- 
