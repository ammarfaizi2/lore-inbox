Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbWAIS1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbWAIS1X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 13:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbWAIS1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 13:27:23 -0500
Received: from mx1.suse.de ([195.135.220.2]:22197 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964915AbWAIS1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 13:27:22 -0500
To: Nauman Tahir <nauman.tahir@gmail.com>
Cc: kernelnewbies@nl.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: X86_64 and X86_32 bit performance difference [Revisited]
References: <f0309ff0601082229u3fc5e415m12be9dc921f4a099@mail.gmail.com>
From: Andi Kleen <ak@suse.de>
Date: 09 Jan 2006 19:27:20 +0100
In-Reply-To: <f0309ff0601082229u3fc5e415m12be9dc921f4a099@mail.gmail.com>
Message-ID: <p734q4dxnnb.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nauman Tahir <nauman.tahir@gmail.com> writes:

> I have posted this problem before. Now mailing again after testing as
> recommeded in previous replys.
> My configuration is:

Most likely it's related to you misusing the PCI DMA API in some way.
Review Documentation/DMA-mapping.txt closely.

If that doesn't turn on the light try oprofile.

-Andi
