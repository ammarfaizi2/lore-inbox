Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282502AbRLSTH0>; Wed, 19 Dec 2001 14:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283724AbRLSTHQ>; Wed, 19 Dec 2001 14:07:16 -0500
Received: from p0508.as-l043.contactel.cz ([194.108.243.254]:9732 "EHLO devix")
	by vger.kernel.org with ESMTP id <S282502AbRLSTHJ>;
	Wed, 19 Dec 2001 14:07:09 -0500
Date: Wed, 19 Dec 2001 19:55:19 +0100 (CET)
From: devik <devik@cdi.cz>
X-X-Sender: <devik@devix>
To: <linux-kernel@vger.kernel.org>
Subject: gcc 3.0.2/kernel details (-O issue)
Message-ID: <Pine.LNX.4.33.0112191508060.2688-100000@devix>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
just another crash report. But interesting one IMHO.
When I compile 2.3.16/SMP with gcc 3.0.2 then it works.
But when I changed -O2 to -O (compile speed reasons)
the compilation succeeded but kernel crashed during
boot (in sys_sigreturn).

devik


