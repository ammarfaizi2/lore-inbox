Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265748AbUBPTEo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 14:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265753AbUBPTEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 14:04:44 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:17384 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S265748AbUBPTEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 14:04:43 -0500
Message-ID: <4031138E.6080400@t-online.de>
Date: Mon, 16 Feb 2004 20:01:34 +0100
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040214
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ryan Reich <ryanr@uchicago.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2: "-" or "_", thats the question
References: <1o903-5d8-7@gated-at.bofh.it> <1pkw6-3BU-3@gated-at.bofh.it> <1prnS-4x8-1@gated-at.bofh.it> <402F8A00.8030501@uchicago.edu> <40306F65.8060702@t-online.de> <Pine.LNX.4.58.0402160808100.14001@ryanr.aptchi.homelinux.org> <Pine.LNX.4.58.0402160819260.14414@ryanr.aptchi.homelinux.org>
In-Reply-To: <Pine.LNX.4.58.0402160819260.14414@ryanr.aptchi.homelinux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: TznP4BZUZeMiLEuVZMdUE73gfHUAvNwfoBvYOZK2bcxHXuu+oxZfcV
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Reich wrote:
> On Mon, 16 Feb 2004, Ryan Reich wrote:
> 
> 
> 
> Sorry, I didn't realize that your problem was also the inconsistency in module
> names.  Someone else suggested using a shell expansion; you could try
> 
> cat /proc/modules | tr _ - | grep -q "^${module_name/_/-}"
> 
> which is both short and works.
> 

tr is usually in /usr/bin, which might not be available
at boot time. And probably you mean 'grep -q "^${module_name//_/-}"'


Did I mention that the inconsistency requires ugly and error-
prone workarounds? QED


Regards

Harri
