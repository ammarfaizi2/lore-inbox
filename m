Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWIKQ61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWIKQ61 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 12:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWIKQ61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 12:58:27 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:40388
	"EHLO gwia-smtp.id2.novell.com") by vger.kernel.org with ESMTP
	id S932341AbWIKQ60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 12:58:26 -0400
From: Jean Delvare <jdelvare@suse.de>
Organization: SUSE
To: Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [PATCH 0/3] proc: bye bye tasklist_lock
Date: Mon, 11 Sep 2006 13:19:41 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org
References: <20060909221839.GA141@oleg>
In-Reply-To: <20060909221839.GA141@oleg>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609111319.42132.jdelvare@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

On Sunday 10 September 2006 00:18, Oleg Nesterov wrote:
> fs/proc/ does not use tasklist_lock anymore.
>
> These patches are simple enough and do not depend on each other.
> The only problem I don't know how to really test them.

Just to make sure I understand what it is all about: Is there a relation 
between this patchset and the recent patch from Eric fixing the 
readdir(/proc) race?

Thanks,
-- 
Jean Delvare
