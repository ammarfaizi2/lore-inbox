Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbVCIOFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVCIOFT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 09:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVCIOFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 09:05:19 -0500
Received: from av10-1-sn2.hy.skanova.net ([81.228.8.181]:18589 "EHLO
	av10-1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S261669AbVCIOFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 09:05:15 -0500
Message-ID: <422F04F7.1020701@home.se>
Date: Wed, 09 Mar 2005 15:15:19 +0100
From: Gustav Lidberg <gustavl@home.se>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: sv, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: make menuconfig creates erronous config for 386
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

There is a bug in "make menuconfig". If one chooses 386 or 486 for cpu
type, CONFIG_X86_TSC=y is set in .config. This creates a kernel that is
unbootable on 386. Testing shows that it worked in 2.4.19, but is broken
from 2.4.20 onwards. Someone should definetely look into this.
(I'm not subscribed to lkml)


/Gustav Lidberg




