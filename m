Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbUE0DxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUE0DxI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 23:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbUE0DxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 23:53:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:9168 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261563AbUE0DxG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 23:53:06 -0400
Date: Wed, 26 May 2004 20:52:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Antonio Larrosa =?ISO-8859-1?B?Smlt6W5leg==?= <antlarr@tedial.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: iowait problems on 2.6, not on 2.4
Message-Id: <20040526205225.7a0866aa.akpm@osdl.org>
In-Reply-To: <200405261743.28111.antlarr@tedial.com>
References: <200405261743.28111.antlarr@tedial.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonio Larrosa Jiménez <antlarr@tedial.com> wrote:
>
> My next test will be to do the "dd tests" on one of the internal hard disks 
>  and use it for the data instead of the external raid.

That's a logical next step.  The reduced read bandwith on the raid array
should be fixed up before we can go any further.  I don't recall any
reports of qlogic fc-scsi performance regressions though.
