Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVCUSqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVCUSqe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 13:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVCUSqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 13:46:34 -0500
Received: from c7ns3.center7.com ([216.250.142.14]:7567 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S261532AbVCUSqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 13:46:32 -0500
Message-ID: <423F13EA.6050007@utah-nac.org>
Date: Mon, 21 Mar 2005 11:35:22 -0700
From: jmerkey <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: clone() and pthread_create() segment fault in 2.4.29
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In case nobody has already reported it, clone() and pthread_create() 
return SIGSEGV faults
when a 2.4.29 kernel on the Taroon Red Hat release.

Jeff
