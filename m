Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263304AbUEBVkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263304AbUEBVkA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 17:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263307AbUEBVkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 17:40:00 -0400
Received: from limicola.its.UU.SE ([130.238.7.33]:29645 "EHLO
	limicola.its.uu.se") by vger.kernel.org with ESMTP id S263304AbUEBVj7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 17:39:59 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: strange ext3 corruption problem on 2.6.x (good news, it seems)
References: <1A9QG-4Y9-7@gated-at.bofh.it> <1A9QH-4Y9-9@gated-at.bofh.it>
 <1A9QG-4Y9-5@gated-at.bofh.it>
From: Thorild Selen <thorild@Update.UU.SE>
Date: Sun, 02 May 2004 23:39:41 +0200
In-Reply-To: <1A9QG-4Y9-5@gated-at.bofh.it> (Thorild Selen's message of
 "Tue, 16 Mar 2004 00:40:07 +0100")
Message-ID: <x3kzn8q33vm.fsf_-_@Psilocybe.Update.UU.SE>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brief followup to the ext3 on LVM on MD with SMP/HT brokenness:

It seems like recent jbd or DM locking fixes have solved this. I have
tried stressing the fs hard for days to reproduce it with 2.6.6-rc2
(otherwise using the same setup), but everything seems to keep working
as it should.


Thorild Selén
Datorföreningen Update / Update Computer Club, Uppsala, SE
