Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbVCTKch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbVCTKch (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 05:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbVCTKch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 05:32:37 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:24732 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262114AbVCTKcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 05:32:36 -0500
Date: Sun, 20 Mar 2005 11:32:34 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/5] Introduce proc_domode
In-Reply-To: <1111313683.EA21f.17773@neapel230.server4you.de>
Message-ID: <Pine.LNX.4.61.0503201131510.4344@yvahk01.tjqt.qr>
References: <1111313683.EA21f.17773@neapel230.server4you.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+#define MAXMODE		07777

I think this should be 0777. SUID, SGID and sticky bit do not belong into 
/proc.


Jan Engelhardt
-- 
