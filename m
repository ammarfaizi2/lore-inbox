Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262803AbVGKVvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262803AbVGKVvR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 17:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262654AbVGKVtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 17:49:22 -0400
Received: from n1.cetrtapot.si ([212.30.80.17]:42464 "EHLO n1.cetrtapot.si")
	by vger.kernel.org with ESMTP id S262759AbVGKVrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 17:47:52 -0400
Message-ID: <42D2E8FE.3000600@cetrtapot.si>
Date: Mon, 11 Jul 2005 23:47:42 +0200
From: Hinko Kocevar <hinko.kocevar@cetrtapot.si>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GIT problems.
References: <Pine.LNX.4.56.0507111758300.15333@pentafluge.infradead.org>
In-Reply-To: <Pine.LNX.4.56.0507111758300.15333@pentafluge.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
> 
> I'm having trouble merging my local branch to the latest tree from linus.

I'm seeing similar error here (today cogito):
$ cg-clone http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
defaulting to local storage area
23:45:39 
URL:http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/heads/master 
[41/41] -> "refs/heads/origin" [1]
progress: 2 objects, 905 bytes
error: File 2a7e338ec2fc6aac461a11fe8049799e65639166 
(http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/2a/7e338ec2fc6aac461a11fe8049799e65639166) 
corrupt

Cannot obtain needed blob 2a7e338ec2fc6aac461a11fe8049799e65639166
while processing commit 0000000000000000000000000000000000000000.
cg-pull: objects pull failed
cg-init: pull failed


-- 
..because under Linux "if something is possible in principle,
then it is already implemented or somebody is working on it".

					--LKI
