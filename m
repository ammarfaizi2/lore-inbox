Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758012AbWLCRXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758012AbWLCRXj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 12:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758135AbWLCRXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 12:23:39 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:14194 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1758012AbWLCRXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 12:23:38 -0500
Date: Sun, 3 Dec 2006 09:24:15 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel: replace "kmalloc+memset" with kzalloc in
 kernel/ dir
Message-Id: <20061203092415.f68bfb87.randy.dunlap@oracle.com>
In-Reply-To: <Pine.LNX.4.64.0612030829400.3793@localhost.localdomain>
References: <Pine.LNX.4.64.0612030829400.3793@localhost.localdomain>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Dec 2006 08:31:50 -0500 (EST) Robert P. J. Day wrote:

> 
>   Replace kmalloc()+memset() combination with kzalloc().
> 
> Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
> 
> ---
> 
>  auditfilter.c |    3 +--
>  futex.c       |    4 +---
>  kexec.c       |    3 +--
>  3 files changed, 3 insertions(+), 7 deletions(-)

Please use diffstat -p1 -w70 as indicated in
Documentation/SubmittingPatches.

---
~Randy
