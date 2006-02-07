Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWBGRjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWBGRjr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 12:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWBGRjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 12:39:47 -0500
Received: from terminus.zytor.com ([192.83.249.54]:32458 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932193AbWBGRjq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 12:39:46 -0500
Message-ID: <43E8DB58.7000600@zytor.com>
Date: Tue, 07 Feb 2006 09:39:36 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: klibc list <klibc@zytor.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: kernel + klibc tree now, in theory, feature-complete
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have updated and pushed the klibc-kernel tree.  "In theory" it should 
be a 1:1 replacement for any stock kernel, which kinit taking up the slack.

Anyway, I haven't yet removed any in-kernel functionality, but that's 
hopefully coming; the in-kernel functionality won't be executed in 
either case.

git://git.kernel.org/pub/linux/kernel/git/hpa/linux-2.6-klibc.git

	-hpa


P.S. It's going to be important to move the standalone klibc to the same 
directory structure as the in-kernel klibc, i.e. klibc-renamed, and 
relatively soon.  It's too easy to confuse even the recursive git policy.
