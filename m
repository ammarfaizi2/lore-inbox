Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbVBOLBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVBOLBt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 06:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbVBOLBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 06:01:49 -0500
Received: from dialpool3-60.dial.tijd.com ([62.112.12.60]:40626 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S261678AbVBOLBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 06:01:45 -0500
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Pty is losing bytes
Date: Tue, 15 Feb 2005 12:01:43 +0100
User-Agent: KMail/1.7.2
References: <20050215020011.39543.qmail@web50201.mail.yahoo.com> <jewttartd5.fsf@sykes.suse.de>
In-Reply-To: <jewttartd5.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502151201.44859.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 February 2005 11:48, Andreas Schwab wrote:
> Alex Davis <alex14641@yahoo.com> writes:
> > Problem does not exist on 2.6.8.1.
>
> Yes, it is a pretty recent regression, reproducable since 2.6.10.

Confirmed against 2.6.11-rc4

devilkin@precious:/tmp$ ./a.out < laptop-mode.txt | diff laptop-mode.txt -
97c97
< ext3 or ReiserFS filesystems (also done automatically by the control script),
---
> ext3 or eiserFS filesystems (also done automatically by the control script),


Jan

-- 
An American is a man with two arms and four wheels.
  -- A Chinese child
