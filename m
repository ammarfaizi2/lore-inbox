Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030602AbVKDElT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030602AbVKDElT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 23:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030605AbVKDElT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 23:41:19 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:55520 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030602AbVKDElS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 23:41:18 -0500
Date: Fri, 4 Nov 2005 04:41:18 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Dave Jones <davej@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dmitry Torokhov <dtor@mail.ru>
Subject: Re: [PATCH] I8K: convert to seqfile
Message-ID: <20051104044118.GF7992@ftp.linux.org.uk>
References: <200506260103.j5Q13ovn020970@hera.kernel.org> <20051104041902.GA23618@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104041902.GA23618@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 11:19:02PM -0500, Dave Jones wrote:
> The missing '?' field is puzzling though. Looking at the diff,
> this should work.  Is this a shortfalling of seq_file perhaps ?

dmi_get_system_info() returns "" instead of "?" now, apparently...
