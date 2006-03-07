Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWCGQew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWCGQew (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 11:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWCGQew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 11:34:52 -0500
Received: from odin2.bull.net ([192.90.70.84]:46998 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S1751258AbWCGQev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 11:34:51 -0500
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: linux-kernel@vger.kernel.org, ltt-dev@shafik.org
Subject: RT patch and arch/i386/kernel/time.c question
Date: Tue, 7 Mar 2006 17:42:41 +0100
User-Agent: KMail/1.7.1
Cc: Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <compudj@krystal.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603071742.42262.Serge.Noiraud@bull.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

	I'm trying to port the LTTng patch over the rt20 and I got the following problem :
The LTTng patch try to modify the arch/i386/kernel/time.c file in which the 
timer_interrupt function doesn't exist anymore.

In which file / function could I try to patch the equivalent function ?

-- 
Serge Noiraud
