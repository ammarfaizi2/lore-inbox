Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbVKNQwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbVKNQwZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 11:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbVKNQwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 11:52:25 -0500
Received: from chello212017098056.surfer.at ([212.17.98.56]:39953 "EHLO
	hofr.at") by vger.kernel.org with ESMTP id S1751194AbVKNQwZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 11:52:25 -0500
From: Der Herr Hofrat <der.herr@hofr.at>
Message-Id: <200511150514.jAF5Eli08483@hofr.at>
Subject: schedule_work in net/*
To: linux-kernel@vger.kernel.org
Date: Tue, 15 Nov 2005 06:14:47 +0100 (CET)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi !

 while looking for a posibly work queue related problem i noticed
 that the return value of schedule_work/scheule_delayed_work is not
 checked in the networking code (and in other cases aswell) - is there
 a particular reason for this - or has it just been forgotten ?
 Atleast in the network code it looks like events could be silently
 lost. (net/core/link_watch.c ipv4/inet_timewait_sock.c etc.) 

thx !
hofrat
