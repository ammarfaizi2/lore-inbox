Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965024AbVLVSM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbVLVSM4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 13:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965172AbVLVSM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 13:12:56 -0500
Received: from webmail.univie.ac.at ([131.130.1.47]:21734 "EHLO
	webmail1.univie.ac.at") by vger.kernel.org with ESMTP
	id S965024AbVLVSMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 13:12:55 -0500
Message-ID: <1167.81.217.14.229.1135275158.squirrel@webmail.univie.ac.at>
In-Reply-To: <20051222173704.GB23411@buici.com>
References: <200512221352.23393.axel.kernel@kittenberger.net>
    <20051222173704.GB23411@buici.com>
Date: Thu, 22 Dec 2005 19:12:38 +0100 (CET)
Subject: Re: Possible Bootloader Optimization in inflate (get rid of 
     unnecessary 32k Window)
From: "Axel Kittenberger" <axel.kittenberger@univie.ac.at>
To: "Marc Singer" <elf@buici.com>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Have you timed this operation?  I would predict that the time to copy
> the kernel is nominal as compared the the time taken to perform the
> decompression.

In the current version it is defleated AND copied. The optimization would
reduce it by 1 copy.

Greetings, Axel
