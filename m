Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbVEDFiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbVEDFiv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 01:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbVEDFiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 01:38:51 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:55427 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S262027AbVEDFit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 01:38:49 -0400
Message-Id: <1115185128.12535.233322099@webmail.messagingengine.com>
X-Sasl-Enc: od2ieHMv3zcyPUlrY8u/dioDhNmwBZ67z/IxfvxP+o9z 1115185128
From: "Deepak" <deepakgaur@fastmail.fm>
To: linux-kernel@vger.kernel.org
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MIME::Lite 1.5  (F2.73; T1.001; A1.64; B3.05; Q3.03)
Subject: Hanged/Hunged process in Linux
Date: Wed, 04 May 2005 14:38:48 +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am working on a Linux based system and developing a monitoring process
which shall do the following function

(1) It will detect abnormally terminated application process and will
restart the process group

(2) It will detect a hanged application and will restart it

My query is regarding second point . What should be the proper
definition of a "Hanged Process" in Linux context . I searched on google
regarding it and got the following definitions

(1) A process not accepting any signals and consuming system resources
(2) A process in STOP state
(3) A process in deadlock state

Process conforming to definition 3 will be due to race conditions/bad
programming.Definition 1 does define a proper hanged process but is it
possible to create such a process in LInux as in linux signal delivery
to the process and its handling is assured by the Linux kernel.

Anybody having another definition for a "Hanged process" in Linux
context

Deepak Gaur
