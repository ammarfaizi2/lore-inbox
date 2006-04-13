Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbWDMO2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbWDMO2o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 10:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbWDMO2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 10:28:44 -0400
Received: from [4.79.56.4] ([4.79.56.4]:13795 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S964948AbWDMO2o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 10:28:44 -0400
Subject: Re: [PATCH] pids: simplify do_each_task_pid/while_each_task_pid
From: Arjan van de Ven <arjan@infradead.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060413175431.GA108@oleg>
References: <20060413163727.GA1365@oleg>
	 <20060413133814.GA29914@infradead.org>  <20060413175431.GA108@oleg>
Content-Type: text/plain
Date: Thu, 13 Apr 2006 16:27:19 +0200
Message-Id: <1144938439.3206.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Then the caller should check find_pid() doesn't return NULL. But yes,
> we can hide this check inside for_each_task_pid().
> 
> But what about current users of do_each_task_pid ? We can't just remove
> these macros.

you can if you fix the callers :)


