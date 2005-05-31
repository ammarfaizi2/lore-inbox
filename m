Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVEaTRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVEaTRs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 15:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVEaTRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 15:17:48 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:63929 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S261330AbVEaTRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 15:17:32 -0400
Message-ID: <429CB7CF.2000200@ammasso.com>
Date: Tue, 31 May 2005 14:15:27 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Reply-To: linux-kernel@vger.kernel.org
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: get_user_pages() and process termination
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I call get_user_pages() on some pages owned by a process, and then the process exits, 
are the pages still pinned, or is there some kind of automatic cleanup?

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13
