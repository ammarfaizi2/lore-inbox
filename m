Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265517AbSKAAsD>; Thu, 31 Oct 2002 19:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265515AbSKAAsD>; Thu, 31 Oct 2002 19:48:03 -0500
Received: from hera.cwi.nl ([192.16.191.8]:37263 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S265517AbSKAAsC>;
	Thu, 31 Oct 2002 19:48:02 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 1 Nov 2002 01:53:46 +0100 (MET)
Message-Id: <UTC200211010053.gA10rk619405.aeb@smtp.cwi.nl>
To: viro@math.psu.edu
Subject: mount
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(i) I just tried 2.5.45 - CLONE_NEWNS is indeed wrong,
and the indicated patch fixes this. Will submit it to
Linus one of these centuries unless you object -
assuming that I can convince myself of the correctness.

(ii) The reason I write is that it will soon be time
for util-linux 2.12. Mount still lacked syntax for
MS_REC, and a moment ago I made it --rbind
(for MS_REC|MS_BIND).
Please complain if MS_REC should remain undocumented
and inaccessible.

Andries

