Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264414AbUFPSqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264414AbUFPSqt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 14:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264452AbUFPSqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 14:46:49 -0400
Received: from peabody.ximian.com ([130.57.169.10]:14274 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S264414AbUFPSqs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 14:46:48 -0400
Subject: Re: Programtically tell diff between HT and real
From: Robert Love <rml@ximian.com>
To: Phy Prabab <phyprabab@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1087408567.7869.1.camel@localhost>
References: <20040616174646.70010.qmail@web51805.mail.yahoo.com>
	 <1087408567.7869.1.camel@localhost>
Content-Type: text/plain
Date: Wed, 16 Jun 2004 14:46:47 -0400
Message-Id: <1087411607.7869.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-16 at 13:56 -0400, Robert Love wrote:

> Yah.  Look at /proc/cpuinfo.
> 
> Virtual processors have different 'processor' values but the same
> 'physical id', while physical processors obviously have different values
> for both.

Oh, and if you just want to see if a processor supports HT - the 'ht'
flag is set in 'flags' in /proc/cpuinfo.

	Robert Love


