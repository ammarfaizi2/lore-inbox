Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262245AbVEROTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbVEROTK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 10:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262242AbVEROLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 10:11:23 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:23817 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S262201AbVEROB6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 10:01:58 -0400
To: John Clark <jclark@metricsystems.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GDB, pthreads, and kernel threads
References: <428A8034.801@metricsystems.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: ed  ::  20-megaton hydrogen bomb : firecracker
Date: Wed, 18 May 2005 15:01:48 +0100
In-Reply-To: <428A8034.801@metricsystems.com> (John Clark's message of "18
 May 2005 00:54:57 +0100")
Message-ID: <8764xg63ar.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 May 2005, John Clark announced authoritatively:
> Most of my work has been in the kernel and I had not paid attention to
> user 'threads'. However, I have at the moment to a need to debug a
> user 'pthread' based applicaiton, that I may want to move into the kernel.
> 
> However, I can't seem to figure out how to get GDB to debug my user
> pthreads app. What is the correct setup to debug pthreads based applications
> now that it seems that pthreads implementation generates processes/threads
> in the kernel.

Use a recent GDB (>=6.2) and things should just work. (At least, they do
for me.)

-- 
`End users are just test loads for verifying that the system works, kind of
 like resistors in an electrical circuit.' - Kaz Kylheku in c.o.l.d.s
