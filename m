Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbUCQWAn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 17:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbUCQWAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 17:00:43 -0500
Received: from peabody.ximian.com ([130.57.169.10]:7644 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262101AbUCQWAm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 17:00:42 -0500
Subject: Re: status of PREEMPT and SMP together?
From: Robert Love <rml@ximian.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4058C37F.8070409@nortelnetworks.com>
References: <4058C37F.8070409@nortelnetworks.com>
Content-Type: text/plain
Message-Id: <1079560828.1435.24.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Wed, 17 Mar 2004 17:00:28 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-17 at 16:30, Chris Friesen wrote:

> Some of the Kconfig files (ppc/ppc64) seem to be of the opinion that 
> there are races when both SMP and PREEMPT are enabled.
> 
> Is this still the case, or are they out of date?

Hrm, I thought I sent Anton a patch to fix that.

The comment is out of date.  Technically speaking, the potential
SMP+PREEMPT races exist on UP+PREEMPT, too.

Running SMP+PREEMPT on a 4-way here :-)

	Robert Love


