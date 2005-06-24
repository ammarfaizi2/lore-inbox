Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262559AbVFXN6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262559AbVFXN6W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 09:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbVFXN6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 09:58:21 -0400
Received: from [213.170.72.194] ([213.170.72.194]:36302 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S262602AbVFXNzX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 09:55:23 -0400
Message-ID: <42BC10C9.9020309@oktetlabs.ru>
Date: Fri, 24 Jun 2005 17:55:21 +0400
From: "Artem B. Bityuckiy" <dedekind@oktetlabs.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-1.3.1
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: dipankar@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] files: change fd_install assertion
References: <20050624105011.GB4804@in.ibm.com> <20050624105209.GC4804@in.ibm.com> <20050624105318.GD4804@in.ibm.com> <20050624105410.GE4804@in.ibm.com> <42BBF6D5.2030109@oktetlabs.ru> <20050624130049.GG4804@in.ibm.com>
In-Reply-To: <20050624130049.GG4804@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma wrote:
> Because that way the compare and branch can be ifdefed out when CONFIG_BUG is
> not set. Not to mention BUG_ON() looks more like an assertion.

Surely, even if BUG() will be nothing, the compiler will optimize that?
Yes, it looks better, but I don't like that there was unlikely() before 
and you removed it. I'ts minor though.

-- 
Best regards, Artem B. Bityuckiy
Oktet Labs (St. Petersburg), Software Engineer.
+78124286709 (office) +79112449030 (mobile)
E-mail: dedekind@oktetlabs.ru, web: http://www.oktetlabs.ru
