Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263488AbTJVTo0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 15:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263505AbTJVToZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 15:44:25 -0400
Received: from realityfailure.org ([209.150.103.212]:63145 "EHLO
	bushido.realityfailure.org") by vger.kernel.org with ESMTP
	id S263488AbTJVToA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 15:44:00 -0400
Date: Wed, 22 Oct 2003 15:43:59 -0400 (EDT)
From: John Jasen <jjasen@realityfailure.org>
X-X-Sender: jjasen@bushido
To: linux-kernel@vger.kernel.org
Subject: linux 2.4 problem with qlogicfc modules
Message-ID: <Pine.LNX.4.44.0310221541140.5719-100000@bushido>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


drivers/scsi/qlogicfc.h has #
#define QLOGICFC_REQ_QUEUE_LEN  127

When I use mdadm to build a raid array out of 8 drives on the same 
channel, it can either hang silently or die with a warning that it should 
never get here.

If I up the define to 1023, I am able to build a raid array and run tests 
on it.

-- 
-- John E. Jasen (jjasen@realityfailure.org)
-- User Error #2361: Please insert coffee and try again.


