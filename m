Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751570AbWCBQTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbWCBQTE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 11:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbWCBQTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 11:19:04 -0500
Received: from wp051.webpack.hosteurope.de ([80.237.132.58]:50571 "EHLO
	wp051.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S1751570AbWCBQTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 11:19:03 -0500
Message-ID: <44071AF3.1010400@steffenweber.net>
Date: Thu, 02 Mar 2006 17:18:59 +0100
From: Steffen Weber <email@steffenweber.net>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Another compile problem with 2.6.15.5 on AMD64
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I´m getting a compile error with 2.6.15.5 on x86_64 using GCC 3.4.4 
(does not seem to be related to the NFS one):

   CC      mm/mempolicy.o
mm/mempolicy.c: In function `get_nodes':
mm/mempolicy.c:527: error: `BITS_PER_BYTE' undeclared (first use in
this function)
mm/mempolicy.c:527: error: (Each undeclared identifier is reported only
once
mm/mempolicy.c:527: error: for each function it appears in.)

It works fine on x86 machines.

Steffen Weber
