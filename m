Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135644AbRDXSJr>; Tue, 24 Apr 2001 14:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135560AbRDXSJ3>; Tue, 24 Apr 2001 14:09:29 -0400
Received: from goat.cs.wisc.edu ([128.105.166.42]:8720 "EHLO goat.cs.wisc.edu")
	by vger.kernel.org with ESMTP id <S135644AbRDXSJO>;
	Tue, 24 Apr 2001 14:09:14 -0400
To: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: Global FPU corruption in 2.2
In-Reply-To: <cpxu23etpmc.fsf@goat.cs.wisc.edu>
	<20010424164721.3598.qmail@theseus.mathematik.uni-ulm.de>
From: Victor Zandy <zandy@cs.wisc.edu>
Date: 24 Apr 2001 13:09:04 -0500
In-Reply-To: "Christian Ehrhardt"'s message of "Tue, 24 Apr 2001 18:47:21 +0200"
Message-ID: <cpxn196rwzj.fsf@goat.cs.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de> writes:
> Victor: Could you try to reproduce the system wide corruption if you
> add an explicit call to stts(); at the very end of __switch_to?
> This should prevent the FPU corruption from spreading.

After adding this call, I cannot reproduce the global corruption.
There is still occasional local corruption of individual pi processes
while pt is running.

Vic




