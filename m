Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932566AbWHQSQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbWHQSQd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 14:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbWHQSQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 14:16:33 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:21459
	"EHLO gwia-smtp.id2.novell.com") by vger.kernel.org with ESMTP
	id S932566AbWHQSQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 14:16:32 -0400
From: Jean Delvare <jdelvare@suse.de>
Organization: SUSE
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC] ps command race fix
Date: Thu, 17 Aug 2006 20:16:04 +0200
User-Agent: KMail/1.9.1
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, pj@sgi.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org, acahalan@gmail.com
References: <20060714203939.ddbc4918.kamezawa.hiroyu@jp.fujitsu.com> <20060817153258.8dfe5973.kamezawa.hiroyu@jp.fujitsu.com> <m1fyfvzdl2.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1fyfvzdl2.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608172016.05232.jdelvare@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric,

On Thursday 17 August 2006 15:39, Eric W. Biederman wrote:
> Here is a respin with a fixed version of next_tgid.  I believe
> I have all of the silly corner cases handled.  So if the pid
> I have found is only a process group or session id or not
> a thread_group leader it should not be ignored.

On what tree is this patch based? It doesn't appear to apply to 
2.6.18-rc4, nor 2.6.18-rc4-mm1.

Thanks,
-- 
Jean Delvare
