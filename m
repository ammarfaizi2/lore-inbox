Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVBDL1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVBDL1Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 06:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbVBDL1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 06:27:24 -0500
Received: from mail1.skjellin.no ([80.239.42.67]:15340 "EHLO mx1.skjellin.no")
	by vger.kernel.org with ESMTP id S261676AbVBDL1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 06:27:18 -0500
Message-ID: <42035C14.70906@tomt.net>
Date: Fri, 04 Feb 2005 12:27:16 +0100
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jerome lacoste <jerome.lacoste@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Huge unreliability - does Linux have something to do with it?
References: <5a2cf1f605020401037aa610b9@mail.gmail.com>
In-Reply-To: <5a2cf1f605020401037aa610b9@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jerome lacoste wrote:
> Attached the output of smartctl -a /dev/hda, whatever that helps.

Judging from the SMART output, this drive seems hosed. All firmware 
controlled extended off-line self-tests have failed on LBA 92491576, and 
it has a worrying amount of re-allocated sectors.

New laptop harddrives shouldn't be too hard to get hold of.
