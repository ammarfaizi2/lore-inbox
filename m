Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263230AbTJKCqN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 22:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263232AbTJKCqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 22:46:13 -0400
Received: from ms-smtp-05.texas.rr.com ([24.93.36.233]:56765 "EHLO
	ms-smtp-05.texas.rr.com") by vger.kernel.org with ESMTP
	id S263230AbTJKCqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 22:46:12 -0400
Date: Fri, 10 Oct 2003 21:46:05 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@dell.com>
X-X-Sender: mdomsch@iguana.domsch.com
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: IBM Thinkpad A21 BIOS - EDD information wrong
In-Reply-To: <20031010235613.GI19046@kroah.com>
Message-ID: <Pine.LNX.4.44.0310102143550.5365-100000@iguana.domsch.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > /sys/firmware/edd/int13_dev80/raw_data
> Hm, I thought you were going to use the sysfs binary file interface for
> this file, instead of outputing a hex dump.  Any reason for keeping it
> this way?

Laziness?  No really, it just slipped my mind.  I've got the read-disk-sig 
patch I'm working on related to EDD again, so I'll fix it right soon.  
Would that fit under Linus's 'bug-only' policy?

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

