Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318038AbSHVXQ4>; Thu, 22 Aug 2002 19:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318040AbSHVXPw>; Thu, 22 Aug 2002 19:15:52 -0400
Received: from pc-62-31-66-89-ed.blueyonder.co.uk ([62.31.66.89]:33412 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S318038AbSHVXPr>; Thu, 22 Aug 2002 19:15:47 -0400
Date: Fri, 23 Aug 2002 00:19:34 +0100
Message-Id: <200208222319.g7MNJY509078@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 0/2] 2.4.20-pre4/ext3: ext3 dirty buffer management
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, 

This patch set contains the biggest recent change to ext3: a change to
the way it deals with other dirty buffers in the system, making it
robust against things like dump(8) or tune2fs(8) playing with the block
device on a live filesystem.  This patch has been in ext3 CVS for some
time now.

I'll follow up with the other smaller fixes and tweaks in the next
batch.
