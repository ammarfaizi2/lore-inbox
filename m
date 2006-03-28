Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbWC1WG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbWC1WG4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 17:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbWC1WG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:06:56 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55966 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932437AbWC1WGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:06:55 -0500
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: haveblue@us.ibm.com, Kirill Korotaev <dev@sw.ru>,
       linux-kernel@vger.kernel.org, devel@openvz.org, serue@us.ibm.com,
       akpm@osdl.org, sam@vilain.net, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Pavel Emelianov <xemul@sw.ru>, Stanislav Protassov <st@sw.ru>
Subject: Re: [RFC] Virtualization steps
References: <44242A3F.1010307@sw.ru>
	<20060324211917.GB22308@MAIL.13thfloor.at>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 28 Mar 2006 14:58:23 -0700
In-Reply-To: <20060324211917.GB22308@MAIL.13thfloor.at> (Herbert Poetzl's
 message of "Fri, 24 Mar 2006 22:19:17 +0100")
Message-ID: <m164lymdts.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> writes:

>> - network virtualization
>
> here I see many issues, as for example Linux-VServer
> does not necessarily aim for full virtualization, when
> simple and performant isolation is sufficient.

The current technique employed by vserver is implementable
in a security module today.  We are implementing each of
these pieces as a separate namespace.  So actually using
any one of them is optional.  So implementing your current
method of network isolation in a security module should be straight
forward.

Eric
