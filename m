Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbUAWMnq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 07:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbUAWMnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 07:43:46 -0500
Received: from mail.aei.ca ([206.123.6.14]:47048 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261506AbUAWMnp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 07:43:45 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: vts have stopped working here
Date: Fri, 23 Jan 2004 07:43:38 -0500
User-Agent: KMail/1.5.93
References: <224300000.1074839500@[10.10.2.4]> <4010C2BF.7090806@cyberone.com.au>
In-Reply-To: <4010C2BF.7090806@cyberone.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401230743.38488.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Is anyone else having problems with vt(s)?  I can switch between X and vt 1 without
problems.  Trying to use any of the other vt(s) fails.   

A+C+F1 flips from X to vt1
A+F2 flips to vt7 (x)
A+C+F2 from X does nothing

In my logs there are messages about init spawing too fast.  Suspect that these are
the processes for the Vt(s) started with:

2:23:respawn:/sbin/getty 38400 tty2

etc.

Kernel is 2.6.2-rc2, dist is debian unstable with X from experimental.

TIA,
Ed Tomlinson
