Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268214AbUHFRGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268214AbUHFRGQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 13:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268179AbUHFRDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 13:03:19 -0400
Received: from mail.appliedminds.com ([65.104.119.58]:9881 "EHLO
	appliedminds.com") by vger.kernel.org with ESMTP id S268192AbUHFQ6Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 12:58:25 -0400
Message-ID: <4113B80D.9000503@appliedminds.com>
Date: Fri, 06 Aug 2004 09:55:41 -0700
From: James Lamanna <jamesl@appliedminds.com>
User-Agent: Mozilla Thunderbird 0.6+ (X11/20040421)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David N. Welton" <davidw@eidetix.com>
CC: Sascha Wilde <wilde@sha-bang.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 kernel won't reboot on AMD system - 8042 problem?
References: <4112A626.1000706@appliedminds.com> <41133FE1.2040906@eidetix.com>
In-Reply-To: <41133FE1.2040906@eidetix.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David N. Welton wrote:
 > [ Re-added Sascha to the CC, as he's interested in this too. ]
 >
 > James Lamanna wrote:
 >
 >> Change i8042.c:62 to
 >> #define DEBUG
 >> And see what printk's you get on trying to reboot.
 >> i8042_command has a bunch in it that are turned off by default.
 >
 >
 > Excellent suggestion.
 >
 > *With keyboard* :
 >

[snip]

Is that debug output from startup or when you try to reboot the machine?

-- 
James Lamanna
