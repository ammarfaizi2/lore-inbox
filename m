Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbTEAKjg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 06:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbTEAKjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 06:39:36 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:1664 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261204AbTEAKjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 06:39:35 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200305011055.h41Atw9w000174@81-2-122-30.bradfords.org.uk>
Subject: Re: Bootsector corruption
To: Dominik.Strasser@t-online.de (Dominik Strasser)
Date: Thu, 1 May 2003 11:55:58 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3EB0FA98.2080508@t-online.de> from "Dominik Strasser" at May 01, 2003 12:44:40 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I experience the following problem which occurs randomly.
> 
> After a reboot, the Bootsector is often corrupted. The errors reported 
> by lilo differ.
> Today I had 99 (invalid second stage index sector).
> The problem occurs both on cold and on warm boots.
> 
> Re-installing lilo helps (until the next corruption).

Doesn't LILO try to write to the boot sector using the BIOS, during boot?

Maybe you have a hardware problem that is causing that write to fail,
but actual usage of the disk under Linux, (not via the BIOS), is
working fine.

John.
