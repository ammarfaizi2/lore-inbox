Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269091AbUJKPJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269091AbUJKPJz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 11:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269043AbUJKPG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 11:06:26 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:41153 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269038AbUJKPAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 11:00:42 -0400
Subject: Re: [BUG]  oom killer not triggering in 2.6.9-rc3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41672D4A.4090200@nortelnetworks.com>
References: <41672D4A.4090200@nortelnetworks.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097503078.31290.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 11 Oct 2004 14:58:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The OOM killer is a heuristic. Switch the machine to strict accounting
and it'll kill or block memory access correctly.

