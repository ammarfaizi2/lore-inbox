Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269006AbUHMFyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269006AbUHMFyY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 01:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269007AbUHMFyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 01:54:24 -0400
Received: from mail.tpgi.com.au ([203.12.160.103]:65495 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S269006AbUHMFyX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 01:54:23 -0400
Subject: Re: is_head_of_free_region slowing down swsusp
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040812232242.GI15138@elf.ucw.cz>
References: <20040812222348.GA10791@elf.ucw.cz>
	 <1092350569.24776.22.camel@laptop.cunninghams>
	 <20040812232242.GI15138@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1092376269.24776.48.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 13 Aug 2004 15:51:09 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-08-13 at 09:22, Pavel Machek wrote:
> > Take a look at my implementation. I do a one-time pass through the slow
> > path, building a bitmap of free pages. is_head_of_free_region is then
> > simply a O(1) loop through the bitmap.
> 
> I've seen that solution (thanks)... I'd like to do something simpler.

Umm. Okay. I didn't think it was complicated.

Nigel
-- 
Nigel Cunningham
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. But true tolerance can cope with others
being intolerant.

