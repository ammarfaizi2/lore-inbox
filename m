Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268093AbTBNXeB>; Fri, 14 Feb 2003 18:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268118AbTBNXeB>; Fri, 14 Feb 2003 18:34:01 -0500
Received: from air-2.osdl.org ([65.172.181.6]:19072 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S268093AbTBNXeA>;
	Fri, 14 Feb 2003 18:34:00 -0500
Date: Fri, 14 Feb 2003 15:43:49 -0800
From: Bob Miller <rem@osdl.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.60 1/9] Add rename_region().
Message-ID: <20030214234349.GB13336@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices need to call request_region() to reserve io ports before they know
the exact name needed (i.e: parport0).  The new rename_region() method allows
the name to be replaced after the real name is known.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
