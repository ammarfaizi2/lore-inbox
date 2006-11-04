Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965606AbWKDUA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965606AbWKDUA4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 15:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965572AbWKDUAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 15:00:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:55368 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965613AbWKDUAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 15:00:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=XZwbZ7RKC6OErFy2aXZ5xOONGXHDq5utkISwMxdepsSUWLqYLZ6jawn4KJzaJlMNxunXxsixenPyVNcyRw/nbb+FGZma4prGM2xLCH9tUIGXytyTw8BI0uiRqC3kG0YiMyjdT40a1oEu3UAWd5gQ7REhysApvroOWQZTVvyMHxM=
Message-ID: <86802c440611041200t5b1c5de6gb72c281de9efed21@mail.gmail.com>
Date: Sat, 4 Nov 2006 12:00:52 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC][PATCH 2/2] htirq: Allow buggy drivers of buggy hardware to write the registers.
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, olson@pathscale.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <m1odrnro6l.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
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
X-Google-Sender-Auth: 1cc31e2cedbc70dc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if (!likely(cfg->update)) {

or

if (likely(!cfg->update)) {

YH
