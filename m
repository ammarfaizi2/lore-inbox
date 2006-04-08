Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWDHNlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWDHNlF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 09:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWDHNlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 09:41:04 -0400
Received: from ns2.suse.de ([195.135.220.15]:29865 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750785AbWDHNlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 09:41:03 -0400
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Black box flight recorder for Linux
References: <44379AB8.6050808@superbug.co.uk>
From: Andi Kleen <ak@suse.de>
Date: 08 Apr 2006 15:41:02 +0200
In-Reply-To: <44379AB8.6050808@superbug.co.uk>
Message-ID: <p73odzc9ocx.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Courtier-Dutton <James@superbug.co.uk> writes:
> 
> Now, the question I have is, if I write values to RAM, do any of those
> values survive a reset?

They don't generally.

Some people used to write the oopses into video memory, but that
is not portable.

-Andi
