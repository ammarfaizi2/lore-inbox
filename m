Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264348AbUFPR4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264348AbUFPR4O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 13:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264355AbUFPR4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 13:56:13 -0400
Received: from peabody.ximian.com ([130.57.169.10]:39361 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S264348AbUFPR4I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 13:56:08 -0400
Subject: Re: Programtically tell diff between HT and real
From: Robert Love <rml@ximian.com>
To: Phy Prabab <phyprabab@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040616174646.70010.qmail@web51805.mail.yahoo.com>
References: <20040616174646.70010.qmail@web51805.mail.yahoo.com>
Content-Type: text/plain
Date: Wed, 16 Jun 2004 13:56:07 -0400
Message-Id: <1087408567.7869.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-16 at 10:46 -0700, Phy Prabab wrote:

> Is there a way to tell the difference between normal
> processors and HT enabled processors?  That is, does
> the linux kernel know the difference and is there a
> way to to know the difference.

Yah.  Look at /proc/cpuinfo.

Virtual processors have different 'processor' values but the same
'physical id', while physical processors obviously have different values
for both.

	Robert Love


