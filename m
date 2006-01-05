Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752213AbWAEVjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213AbWAEVjT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 16:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752214AbWAEVjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 16:39:19 -0500
Received: from linux.dunaweb.hu ([62.77.196.1]:45698 "EHLO linux.dunaweb.hu")
	by vger.kernel.org with ESMTP id S1750960AbWAEVjS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 16:39:18 -0500
Message-ID: <43BD9A17.4010305@freemail.hu>
Date: Thu, 05 Jan 2006 23:13:43 +0100
From: Zoltan Boszormenyi <zboszor@freemail.hu>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: hu-hu, hu, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bad page state in 2.6.15
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just got this on FC3, a shiny new compiled 2.6.15 kernel:

Bad page state at prep_new_page (in process 'cc1', page ffff8100018e1278)
flags:0x4000000000000004 mapping:0000000000000000 mapcount:0 count:-131072
Backtrace:

Call Trace:<ffffffff8015536e>{bad_page+113} 
<ffffffff80155edf>{get_page_from_freelist+702}
       <ffffffff80156032>{__alloc_pages+80} 
<ffffffff80160f8b>{__handle_mm_fault+453}
       <ffffffff8011edd6>{do_page_fault+959} 
<ffffffff80164225>{do_mmap_pgoff+1604}
       <ffffffff8010f0c9>{error_exit+0}
Trying to fix it up, but a reboot is needed

Best regards,
Zoltán Böszörményi

