Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWEPWjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWEPWjY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 18:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWEPWjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 18:39:23 -0400
Received: from gate.crashing.org ([63.228.1.57]:58328 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932233AbWEPWjX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 18:39:23 -0400
Subject: Re: ppc: bogomips at 73 when CPU is at 1GHz
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Junichi Uekawa <dancer@netfort.gr.jp>
Cc: linux-kernel@vger.kernel.org, debian-powerpc@lists.debian.org
In-Reply-To: <87ac9hzn1g.dancerj%dancer@netfort.gr.jp>
References: <87ac9hzn1g.dancerj%dancer@netfort.gr.jp>
Content-Type: text/plain
Date: Wed, 17 May 2006 08:37:13 +1000
Message-Id: <1147819034.6753.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-17 at 06:18 +0900, Junichi Uekawa wrote:
> Hi,
> 
> I've noticed the very log value on bogomips on self-compiled 2.6.16.16
> on iBook G4.

 .../...

Normal. We don't use CPU bogo loops for short timings, we use the CPU
timebase instead, thus you now get bogomips derived from the timebae
frequency of the machine.

Ben.
 

