Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262230AbVFVU5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbVFVU5A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 16:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVFVUwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 16:52:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56518 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262230AbVFVUvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 16:51:44 -0400
Date: Wed, 22 Jun 2005 13:52:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, fastboot@osdl.org
Subject: Re: -mm -> 2.6.13 merge status
Message-Id: <20050622135235.038b5222.akpm@osdl.org>
In-Reply-To: <m1fyvamiyu.fsf@ebiederm.dsl.xmission.com>
References: <20050620235458.5b437274.akpm@osdl.org>
	<42B831B4.9020603@pobox.com>
	<20050621132204.1b57b6ba.akpm@osdl.org>
	<m1fyvamiyu.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
> Andrew the good news is unless something comes up I will have time
> starting about Monday to help with the 2.6.13 merge.  It looks like
> the first thing I should do is split up the indent patch so it pairs
> well with the rest.  And then I have a few pending patches for the user
> space and I think I can fix a number of the device_shutdown problems,
> for at least the normal kexec path.

I'd be inclined to leave it as-is, really.  I'm not sure that it's worth
the effort+risk of significantly refactoring the patches.

I've cut it down from 58 patches to 45 and will take another pass at it in
the next day or two, but it's looking like 40-odd patches is the right
number.
