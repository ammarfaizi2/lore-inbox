Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbTKBPkw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 10:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbTKBPkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 10:40:52 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:16584 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261740AbTKBPku
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 10:40:50 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: uaca@alumni.uv.es
Subject: Re: 2.6.0-test9: BUG alim15x3.c
Date: Sun, 2 Nov 2003 16:45:54 +0100
User-Agent: KMail/1.5.4
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20031102150911.GB14148@pusa.informat.uv.es>
In-Reply-To: <20031102150911.GB14148@pusa.informat.uv.es>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311021645.54838.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 of November 2003 16:09, uaca@alumni.uv.es wrote:
> Hi all

Hi,

> I have an ASUS P5A board with the ALI M5229 IDE controller, the kernel
> (2.6.0-test9) doesn't recognize the partition table (so it cannot but
> the root fs of the disk).

Does it recognize drives correctly?  Does ALI driver oops?
Do you have support for your filesystem compiled-in (not as module).
Have you tried passing "root=/dev/hda" (or similar) boot parameter?

--bartlomiej

