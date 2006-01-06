Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932629AbWAFDUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbWAFDUe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 22:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932631AbWAFDUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 22:20:33 -0500
Received: from [218.25.172.144] ([218.25.172.144]:36362 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S932629AbWAFDUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 22:20:33 -0500
Date: Fri, 6 Jan 2006 11:20:21 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-mm1: what's page_owner.c doing in Documentation/ ???
Message-ID: <20060106032021.GB7152@localhost.localdomain>
References: <9a8748490601051624u36fb03d2l349c40a0165cbddb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490601051624u36fb03d2l349c40a0165cbddb@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 01:24:20AM +0100, Jesper Juhl wrote:
> Just wondering what page_owner.c is doing in Documentation/ in 2.6.15-mm1 ;-)
> 
> $ ls -l linux-2.6.15-mm1/Documentation/page_owner.c
> -rw-r--r--  1 juhl users 2587 2006-01-05 18:15
> linux-2.6.15-mm1/Documentation/page_owner.c

[coywolf@everest ~/linux/2.6.15-mm1]$ head Documentation/page_owner.c
/*
 * User-space helper to sort the output of /proc/page_owner
 *
 * Example use:
 * cat /proc/page_owner > page_owner.txt
 * ./sort page_owner.txt sorted_page_owner.txt
 */

#include <stdio.h>
#include <stdlib.h>

