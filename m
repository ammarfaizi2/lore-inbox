Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWDZRGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWDZRGp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 13:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbWDZRGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 13:06:45 -0400
Received: from pproxy.gmail.com ([64.233.166.182]:39460 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932317AbWDZRGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 13:06:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:thread-index:x-mimeole;
        b=hiOqeqvDGgwWD9dEPwcq572PFaXIMeKsDR5kcvuNRilUUIuD8gdXmsTgCkuj/gB2AH0mhegnrk4Hbvzzc7VfIw7prEsRfsRyQRpCKllwxmy7+zZHEgKCPm+qFtGQ7t4hfE54iBjhHM7MhmGVTuMd4chqNII4nl7RTJ4WnB+Ky4U=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Jens Axboe'" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Subject: RE: [PATCH] likely cleanup: revert unlikely in ll_back_merge_fn
Date: Wed, 26 Apr 2006 10:06:42 -0700
Message-ID: <00c701c66953$cb292070$853d010a@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20060425183026.GR4102@suse.de>
Thread-Index: AcZoljkoV+BecDHHQHWxqMKfjRq2iAAvW+8A
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not at all uninterested in this, I'd just like to see a 
> more intelligent/controlled work load that actually stresses 
> the io subsystem being profiled. If you have a not-so-busy 
> system, you like don't do enough IO to trigger a lot of 
> merges. Or maybe you do, and we just have a bug somewhere so 
> that we unfortunately repeatedly recount segments.

I'm glad we actually found something interesting (bug or not). :-)

