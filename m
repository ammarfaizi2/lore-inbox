Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263235AbTDLLBK (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 07:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263239AbTDLLBJ (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 07:01:09 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:50560 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263235AbTDLLBJ (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 07:01:09 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304121110.h3CBAHkQ000399@81-2-122-30.bradfords.org.uk>
Subject: Re: Completely new idea to virtual memory
To: 76306.1226@compuserve.com (Chuck Ebbert)
Date: Sat, 12 Apr 2003 12:10:17 +0100 (BST)
Cc: john@grabjohn.com (John Bradford),
       linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <200304120554_MC3-1-341A-4160@compuserve.com> from "Chuck Ebbert" at Apr 12, 2003 05:52:43 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Maybe something like this?
> 
>    if about_to_spin_down_disks || swap_disk_idle
>        if lots_of_memory_free
>            page_in
>        if little_memory_free
>            copy_pages_to_swap

Exactly - plus, if the disk is only, or mainly, used for swap, you
could purposely spin it down after doing the speculative swapout.

John.
