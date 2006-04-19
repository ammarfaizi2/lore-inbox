Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbWDSPbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbWDSPbs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 11:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbWDSPbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 11:31:48 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29320 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750842AbWDSPbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 11:31:48 -0400
To: Kirill Korotaev <dev@sw.ru>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       herbert@13thfloor.at, devel@openvz.org, sam@vilain.net, xemul@sw.ru,
       James Morris <jmorris@namei.org>
Subject: Re: [RFC][PATCH 4/5] utsname namespaces: sysctl hack
References: <20060407095132.455784000@sergelap>
	<20060407183600.E40C119B902@sergelap.hallyn.com>
	<4446547B.4080206@sw.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 19 Apr 2006 09:29:32 -0600
In-Reply-To: <4446547B.4080206@sw.ru> (Kirill Korotaev's message of "Wed, 19
 Apr 2006 19:17:15 +0400")
Message-ID: <m1wtdlmvmr.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

> Serge,
>
> can we do nothing with sysctls at this moment, instead of commiting hacks?

Except that we modify a static table changing the uts behaviour in
proc_doutsstring isn't all that bad.

I'm just about to start on something more comprehensive, in
the sysctl case.

Eric
