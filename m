Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263230AbTDLKu7 (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 06:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263233AbTDLKu6 (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 06:50:58 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:47744 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263230AbTDLKu6 (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 06:50:58 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304121105.h3CB5Cta000381@81-2-122-30.bradfords.org.uk>
Subject: Re: Booting Problems in the 2.5 series!
To: mfc@krycek.org (Mads Christensen)
Date: Sat, 12 Apr 2003 12:05:12 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1050144042.11736.4.camel@krycek> from "Mads Christensen" at Apr 12, 2003 12:40:42 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was just wondering, do you have to do something magical to get the 2.5
> series booting, or is it just my debian thats fubar? :)

If you want to use modules, you'll need the new module utilities.

> I've tried 2.5.66 and 2.5.67 and they both halt on the initial line of
> booting - 'Booting Linux, Uncompressing something...' or something like
> that.

If it's failing that early, then something is wrong with the kernel,
or your hardware.  Try earlier kernels until you find one that works,
then post the details, along with things like the output of lspci -v
-v -v.

John.
