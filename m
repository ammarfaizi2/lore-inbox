Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbVBPHNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVBPHNP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 02:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbVBPHNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 02:13:15 -0500
Received: from [194.79.132.36] ([194.79.132.36]:22152 "HELO mail.flinux.net")
	by vger.kernel.org with SMTP id S261623AbVBPHNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 02:13:10 -0500
Date: Wed, 16 Feb 2005 08:13:07 +0100
From: Pierre Morel <pmorel@mnis.fr>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: Serial Driver problems in 2.6
Message-ID: <20050216081307.0e805268@vaio.mnis.priv>
Organization: MNIS
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I saw the discussion between you and Andrew Morton in the LKML on serial
driver's problems.

I think the problem comes, as you said from the serail driver:
According to the tty_io.c file comments:
It should not call the flush of the tty buffer from within interrupt
handler in case of handling low_latency.

IMHO most drivers do that and are buggy.
(or may be I am buggy)
what do you think?

I was not in the lklm at tht time so I cannot answer in the thread, 
so I put you in CC.
I do not have the email address of Andrew Morton.

best regards,

Pierre Morel

-- 
http://www.mnis.fr/
http://www.ocera.org/
Real Time Linux & Linux Security

TEL/FAX: 0820 20 76 22

MNIS
57, rue d'Amsterdam
75008 PARIS

