Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965709AbWKDVWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965709AbWKDVWA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 16:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965710AbWKDVWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 16:22:00 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49553 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965709AbWKDVV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 16:21:59 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Yinghai Lu" <yinghai.lu@amd.com>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, olson@pathscale.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2/2] htirq: Allow buggy drivers of buggy hardware to write the registers.
References: <454A7B0F.7060701@pathscale.com>
	<m1d584xutk.fsf@ebiederm.dsl.xmission.com>
	<454B880A.1010802@pathscale.com>
	<m1zmb8wexd.fsf@ebiederm.dsl.xmission.com>
	<454B8E19.90300@pathscale.com>
	<m1irhww9f9.fsf_-_@ebiederm.dsl.xmission.com>
	<m1ejskw9as.fsf_-_@ebiederm.dsl.xmission.com>
	<200611032146.kA3LkUe9031799@ebiederm.dsl.xmission.com>
	<86802c440611041137t74d84e7at3850fc8a10a314cb@mail.gmail.com>
	<m1odrnro6l.fsf@ebiederm.dsl.xmission.com>
	<86802c440611041200t5b1c5de6gb72c281de9efed21@mail.gmail.com>
Date: Sat, 04 Nov 2006 14:21:33 -0700
In-Reply-To: <86802c440611041200t5b1c5de6gb72c281de9efed21@mail.gmail.com>
	(Yinghai Lu's message of "Sat, 4 Nov 2006 12:00:52 -0800")
Message-ID: <m17iyasyaq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Yinghai Lu" <yinghai.lu@amd.com> writes:

> if (!likely(cfg->update)) {
>
> or
>
> if (likely(!cfg->update)) {

Yes.  Except that the current state of affairs is that the only merged driver
needs this :)

Eric
