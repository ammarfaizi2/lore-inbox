Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbVD1Hta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVD1Hta (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 03:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVD1HtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 03:49:15 -0400
Received: from [213.170.72.194] ([213.170.72.194]:22489 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261922AbVD1Hrf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 03:47:35 -0400
Subject: Re: [PATCH] VFS bugfix: two read_inode() calles without
	clear_inode() call between
From: "Artem B. Bityuckiy" <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, dwmw2@infradead.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <E1DR3ei-0005OC-00@dorka.pomaz.szeredi.hu>
References: <1114607741.12617.4.camel@sauron.oktetlabs.ru>
	 <E1DQoui-0002In-00@dorka.pomaz.szeredi.hu>
	 <1114618748.12617.23.camel@sauron.oktetlabs.ru>
	 <E1DQqZu-0002Rf-00@dorka.pomaz.szeredi.hu>
	 <1114673528.3483.2.camel@sauron.oktetlabs.ru>
	 <E1DR3ei-0005OC-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Organization: MTD
Date: Thu, 28 Apr 2005 11:47:33 +0400
Message-Id: <1114674453.3483.5.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I didn't actually think about the sb_list stuff, but my feeling is you
> should not move it unless there's a very clear reason to do so.

Well, no problems. Probably safeness is of greater priority. I'll take
care not to touch it.

Thanks for review.

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.

