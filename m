Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbVCFMNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVCFMNN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 07:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVCFMNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 07:13:13 -0500
Received: from news.suse.de ([195.135.220.2]:23460 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261387AbVCFMNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 07:13:10 -0500
To: Tom Horsley <tomhorsley@adelphia.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ptrace and setuid problem
References: <422A639A.5090603@adelphia.net>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Yow!  I'm imagining a surfer van filled with soy sauce!
Date: Sun, 06 Mar 2005 13:13:09 +0100
In-Reply-To: <422A639A.5090603@adelphia.net> (Tom Horsley's message of "Sat,
 05 Mar 2005 20:57:46 -0500")
Message-ID: <jeu0npkm5m.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Horsley <tomhorsley@adelphia.net> writes:

> If I exec a setuid program under ptrace, I can read the image via
> PEEKDATA requests.

Only CAP_SYS_PTRACE capable processes get suid/sgid semantics under
ptrace, or can attach to a privileged processes.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
