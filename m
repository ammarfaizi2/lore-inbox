Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVABUro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVABUro (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 15:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVABUrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 15:47:43 -0500
Received: from one.firstfloor.org ([213.235.205.2]:27062 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261328AbVABUrm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 15:47:42 -0500
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] disallow modular capabilities
References: <20050102200032.GA8623@lst.de> <m1mzvry3sf.fsf@muc.de>
	<20050102203005.GA9491@lst.de>
From: Andi Kleen <ak@muc.de>
Date: Sun, 02 Jan 2005 21:47:41 +0100
In-Reply-To: <20050102203005.GA9491@lst.de> (Christoph Hellwig's message of
 "Sun, 2 Jan 2005 21:30:05 +0100")
Message-ID: <m1is6fy2vm.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> On Sun, Jan 02, 2005 at 09:28:00PM +0100, Andi Kleen wrote:
>> Christoph Hellwig <hch@lst.de> writes:
>> 
>> > There's been a bugtraq report about a root exploit with modular
>> > capabilities LSM support out for more than a week.
>> 
>> It was a root exploit only triggerable by root. Not exactly
>> what I would call a real problem.
>
> At least Debian currently inserts the capabilities module on boot.

That is fine as long as they control all code executed before
that module loading.  And if they do not it is their own fault
and they have to fix that in user space or compile the capability in.
Unix policy is to not stop root from doing stupid things because
that would also stop him from doing clever things.

-Anddi
