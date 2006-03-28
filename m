Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbWC1Vy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWC1Vy4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 16:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWC1Vy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 16:54:56 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34206 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932377AbWC1Vyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 16:54:55 -0500
To: Jun OKAJIMA <okajima@digitalinfra.co.jp>
Cc: devel@openvz.org, akpm@osdl.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       sam@vilain.net, linux-kernel@vger.kernel.org,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, serue@us.ibm.com,
       herbert@13thfloor.at
Subject: Re: [Devel] Re: [RFC] Virtualization steps
References: <4429A17D.2050506@openvz.org>
	<200603282138.AA00929@bbb-jz5c7z9hn9y.digitalinfra.co.jp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 28 Mar 2006 14:51:05 -0700
In-Reply-To: <200603282138.AA00929@bbb-jz5c7z9hn9y.digitalinfra.co.jp> (Jun
 OKAJIMA's message of "Wed, 29 Mar 2006 06:38:42 +0900")
Message-ID: <m1ek0mme5y.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jun OKAJIMA <okajima@digitalinfra.co.jp> writes:

> Probably, the biggest problem for now is, Xen patch conflicts with
> Vserver/OpenVZ patch.

The implementations are significantly different enough that I don't
see Xen and any jail patch really conflicting.  There might be some
trivial conflicts in /proc but even that seems unlikely.

Eric
