Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266904AbUFZAO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266904AbUFZAO7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 20:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266765AbUFZAO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 20:14:59 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:5900 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S266904AbUFZAOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 20:14:36 -0400
Date: Sat, 26 Jun 2004 02:14:34 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "Makhlis, Lev" <Lev_Makhlis@bmc.com>
Cc: "'Andries Brouwer'" <aebr@win.tue.nl>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [SYSVIPC] Change shm_tot from int to size_t
Message-ID: <20040626001434.GA5526@pclin040.win.tue.nl>
References: <F12B6443B4A38748AFA644D1F8EF3532147333@bos-ex-01.adprod.bmc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F12B6443B4A38748AFA644D1F8EF3532147333@bos-ex-01.adprod.bmc.com>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : mailhost.tue.nl 1182; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 04:56:32PM -0500, Makhlis, Lev wrote:

> What do you think about following the example of sys_statfs in sys_shmctl?

I don't mind. It is fairly unimportant - just the informative stuff
printed by

% ipcs -m -l

------ Shared Memory Limits --------
max number of segments = 4096
max seg size (kbytes) = 32768
max total shared memory (kbytes) = 8388608
min seg size (bytes) = 1

(but it seems a pity to deny user space this information if only
one field is large).
