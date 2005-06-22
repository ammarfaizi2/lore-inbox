Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262712AbVFVEUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbVFVEUe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 00:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbVFVEUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 00:20:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12444 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262624AbVFVEU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 00:20:28 -0400
Date: Tue, 21 Jun 2005 21:19:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: teigland@redhat.com
Cc: dteigland@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status (configfs)
Message-Id: <20050621211959.73c67442.akpm@osdl.org>
In-Reply-To: <c1e1128f0506212108243e2c3b@mail.gmail.com>
References: <20050620235458.5b437274.akpm@osdl.org>
	<c1e1128f0506212108243e2c3b@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Teigland <dteigland@gmail.com> wrote:
>
> On 6/21/05, Andrew Morton <akpm@osdl.org> wrote:
> > git-ocfs
> > 
> >     The OCFS2 filesystem.  OK by me, although I'm not sure it's had enough
> >     review.
> 
> Does this include configfs?  I'd especially like to see that sooner
> rather than later.

There's not a lot of point in adding a fs which has no in-kernel users.
