Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132691AbRCMVy1>; Tue, 13 Mar 2001 16:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132681AbRCMVyT>; Tue, 13 Mar 2001 16:54:19 -0500
Received: from srv01s4.cas.org ([134.243.50.9]:2465 "EHLO srv01.cas.org")
	by vger.kernel.org with ESMTP id <S132653AbRCMVyA>;
	Tue, 13 Mar 2001 16:54:00 -0500
From: Mike Harrold <mharrold@cas.org>
Message-Id: <200103132153.QAA22914@mah21awu.cas.org>
Subject: Re: Dumping memory of a running process?
To: root@mauve.demon.co.uk (Ian Stirling)
Date: Tue, 13 Mar 2001 16:53:11 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200103132044.UAA24829@mauve.demon.co.uk> from "Ian Stirling" at Mar 13, 2001 08:44:18 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Is there a way to dump the memory of any process without stopping, or 
> modifying it?
> 
> Obviously normally stopping it would be the right thing to do, but
> is it possible, and if so, is there a handy tool?

fork() and raise(SIGABRT) in the child does the trick. Of course this
only works if you have access to the source code.

/Mike
