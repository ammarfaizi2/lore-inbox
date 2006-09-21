Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWIURj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWIURj1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 13:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWIURj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 13:39:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21210 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751381AbWIURj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 13:39:26 -0400
Date: Thu, 21 Sep 2006 10:39:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC][PATCH -mm] replace cad_pid by a struct pid
Message-Id: <20060921103913.007787b8.akpm@osdl.org>
In-Reply-To: <451291D3.10401@fr.ibm.com>
References: <45110C1B.7020304@fr.ibm.com>
	<20060920143028.fd446145.akpm@osdl.org>
	<451291D3.10401@fr.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006 15:21:23 +0200
Cedric Le Goater <clg@fr.ibm.com> wrote:

> do we still need /proc/sys/kernel/cad_pid ?

Some searching indicates that it is used by anaconda, and by something
called "rootskel".

