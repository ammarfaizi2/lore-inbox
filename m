Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbUISTJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUISTJG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 15:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUISTJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 15:09:06 -0400
Received: from mail1.ewetel.de ([212.6.122.12]:18860 "EHLO mail1.ewetel.de")
	by vger.kernel.org with ESMTP id S262329AbUISTJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 15:09:02 -0400
Date: Sun, 19 Sep 2004 21:08:50 +0200 (CEST)
From: Pascal Schmidt <pascal.schmidt@email.de>
To: "P. Benie" <pjb1008@eng.cam.ac.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Design for setting video modes, ownership of sysfs attributes
In-Reply-To: <Pine.HPX.4.58L.0409191541030.24772@punch.eng.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0409192106200.617@neptune.local>
References: <2FYdH-10h-5@gated-at.bofh.it> <2G6Et-6D7-31@gated-at.bofh.it>
 <2G6Et-6D7-31@gated-at.bofh.it> <E1C92WT-00005z-7q@localhost>
 <Pine.HPX.4.58L.0409191541030.24772@punch.eng.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Sep 2004, P. Benie wrote:

> If you're going to subvert an fd, use stdin, not stdout.
> stdin is less valuable most commands use argv rather than stdin, and it
> allows you to retreive the output of a command using the shell `backtick`
> operators.

The point is, you need to make a choice if you want to infer the
tty from an fd. You can't assume stdin and stdout point to the same
console. And if we talk about video mode settings, why would I want
to use the fd that the command gets keyboard input from?

The shell backtick obviously uses stdout of the command inside
the backticks. ;)

-- 
Ciao,
Pascal
