Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264342AbTEaOfF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 10:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264343AbTEaOfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 10:35:05 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:30821 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S264342AbTEaOfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 10:35:04 -0400
Date: Sat, 31 May 2003 10:48:28 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: linux-mm@kvack.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] rmap 15j for 2.4.21-rc6
In-Reply-To: <Pine.LNX.4.44.0305301315440.4407-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.44.0305311047110.20941-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 May 2003, Rik van Riel wrote:

> The tenth maintenance release of the 15th version of the reverse
> mapping based VM is now available.
> This is an attempt at making a more robust and flexible VM
> subsystem, while cleaning up a lot of code at the same time.
> The patch is available from:
> 
>            http://surriel.com/patches/2.4/2.4.21-pre7-rmap15j
> and        http://linuxvm.bkbits.net/

Today I finally merged rmap15j forward to marcelo's latest
release.  The IO stall fixes should be especially interesting:

http://surriel.com/patches/2.4/2.4.21-rc6-rmap15j

