Return-Path: <linux-kernel-owner+w=401wt.eu-S1752103AbWLONFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103AbWLONFh (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 08:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752102AbWLONFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 08:05:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38028 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752100AbWLONFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 08:05:36 -0500
Message-ID: <45829D94.1090304@redhat.com>
Date: Fri, 15 Dec 2006 08:05:24 -0500
From: Jeff Layton <jlayton@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] ensure unique i_ino in filesystems without permanent
 inode numbers (introduction)
References: <457891E7.10902@redhat.com>
In-Reply-To: <457891E7.10902@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Layton wrote:
 > Apologies for the long email, but I couldn't come up with a way to explain
 > this in fewer words. Many filesystems that are part of the linux kernel
 > have problems with how they have assign out i_ino values:
 >

If there are no further comments/suggestions on this patchset, I'd like to
ask Andrew to add it to -mm soon and target getting it rolled into 2.6.21.
Once it's in -mm, I'll start posting more patches to convert the other
filesystems.

Andrew, are the patches I've already posted sufficient, or should I resend
the set?

Thanks,
Jeff


