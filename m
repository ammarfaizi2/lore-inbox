Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWDKKs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWDKKs6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 06:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWDKKs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 06:48:58 -0400
Received: from smtp-out.google.com ([216.239.45.12]:59983 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750728AbWDKKs5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 06:48:57 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=SuDHXomSGT2VTwYDkamyxMLxp78E2o5Dc8J/+I08lqO11RFYdIbS94MQznHi8OnKY
	mzu+FvSokCO4V+fjKaoRQ==
Message-ID: <608a53b0604110348g22445b00u5ef57286eb230d58@mail.google.com>
Date: Tue, 11 Apr 2006 16:18:48 +0530
From: "Prasanna Meda" <mlp@google.com>
To: akpm@osdl.org, ebiederm@xmission.com
Subject: Re: Comment about proc-dont-lock-task_structs-indefinitely.patch
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <608a53b0604101242v4778af80ybaf639c38cc00587@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <608a53b0604101242v4778af80ybaf639c38cc00587@mail.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/06, Prasanna Meda <mlp@google.com> wrote:

>
> The task decrement problem is fixed, but I think we have two more
> problems in the following patch segment.
>

I think you agreed with the first problem. And the second problem is,
show_map_internal is still treating m->private as task_struct instead
of  proc_maps_private.
