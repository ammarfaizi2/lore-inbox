Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWDYJfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWDYJfL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 05:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWDYJfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 05:35:10 -0400
Received: from mail.suse.de ([195.135.220.2]:64192 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932155AbWDYJfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 05:35:09 -0400
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Avoid printing pointless tsc skew msgs.
References: <20060424215239.GA1178@redhat.com>
From: Andi Kleen <ak@suse.de>
Date: 25 Apr 2006 11:35:07 +0200
In-Reply-To: <20060424215239.GA1178@redhat.com>
Message-ID: <p731wvm9ewk.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> writes:

> These messages are kinda silly..
> 
> CPU#0 had 0 usecs TSC skew, fixed it up.
> CPU#1 had 0 usecs TSC skew, fixed it up.
> 
> inspired from: http://bugzilla.kernel.org/attachment.cgi?id=7713&action=view

Actually it's not correct because if you fixed it up it won't be 0 usecs
again because of the error it adds

(I'm actually not sure how it even managed to measure 0 usecs) 

-Andi
