Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbTKYOWe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 09:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbTKYOWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 09:22:34 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:22722 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262655AbTKYOWd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 09:22:33 -0500
Message-ID: <3FC365A4.2010107@cyberone.com.au>
Date: Wed, 26 Nov 2003 01:22:28 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: NUMA node_to_cpumask question
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list, quick question.

On NUMAQ:
take i < MAX_NUMNODES, but a not existant node number.
node_to_cpumask(i) always contains CPU0 in the mask... I think.

Any particular reason for this?


