Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262056AbVBUSCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbVBUSCS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 13:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbVBUSCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 13:02:18 -0500
Received: from hermes.domdv.de ([193.102.202.1]:20242 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S262056AbVBUSCR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 13:02:17 -0500
Message-ID: <421A2355.1030605@domdv.de>
Date: Mon, 21 Feb 2005 19:07:17 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Adriaanse <alex.adriaanse@gmail.com>
CC: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: Odd data corruption problem with LVM/ReiserFS
References: <93ca3067050220212518d94666@mail.gmail.com>	 <4219C811.5070906@domdv.de> <93ca30670502210844578dce95@mail.gmail.com>
In-Reply-To: <93ca30670502210844578dce95@mail.gmail.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Adriaanse wrote:
> The weird thing is I did not see any I/O errors in my logs, and
> running find on /var worked without a problem.  By the way, did you
> take any DM snapshots when you experienced that corruption?

No, no snapshots. Just working find on a large dataset (source tree, 
about 16GB). The fun part is that I got the I/O errors for varying 
diretories and 'ls'-sing thes directories after find failed, too. 
However a follow-up tar to the ieee1394 disk to salvage the data 
actually could access all data correctly. One day before I did 
experience the same symptom but did reboot. This caused actual damage 
all over the place and I had to restore from the last checkpoint I made.

-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
