Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264595AbUEDTEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264595AbUEDTEv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 15:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264597AbUEDTEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 15:04:51 -0400
Received: from grex.cyberspace.org ([216.93.104.34]:53510 "HELO
	grex.cyberspace.org") by vger.kernel.org with SMTP id S264595AbUEDTEt
	(ORCPT <rfc822;linux-kernel@VGER.KERNEL.ORG>);
	Tue, 4 May 2004 15:04:49 -0400
From: Hal Nine <hal9@cyberspace.org>
Message-Id: <200405041905.PAA05084@grex.cyberspace.org>
Subject: Clock skew with hyperthreading and high load?
To: linux-kernel@VGER.KERNEL.ORG
Date: Tue, 4 May 2004 15:05:24 -0400 (EDT)
Cc: hal9@cyberspace.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Intel(R) Xeon(TM) CPU 2.40GHz (stepping 9) running under 2.4.24
with hyperthreading enabled.  I have noticed that, under extremely high
loads (high swap usage including, but this may not be relevant) the system
clock looses a lot of seconds.  For example, when running ntpdate against
a reliable time source every hour, on some runs it corrects only fractions
of seconds, but on other runs it ajusts up to 200 seconds (during exactly
those periods of high load).

Is this a known problem?  Any good solutions/workarounds?

h
