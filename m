Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319323AbSIKUVX>; Wed, 11 Sep 2002 16:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319326AbSIKUVW>; Wed, 11 Sep 2002 16:21:22 -0400
Received: from holomorphy.com ([66.224.33.161]:40906 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S319323AbSIKUVW>;
	Wed, 11 Sep 2002 16:21:22 -0400
Date: Wed, 11 Sep 2002 13:23:20 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Thomas Molina <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 Problem Status Report
Message-ID: <20020911202320.GB3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Thomas Molina <tmolina@cox.net>, linux-kernel@vger.kernel.org
References: <20020911022933.GA3530@holomorphy.com> <Pine.LNX.4.44.0209111321450.10584-100000@dad.molina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209111321450.10584-100000@dad.molina>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2002, William Lee Irwin III wrote:
>> Since 3 of these are things I reported...

On Wed, Sep 11, 2002 at 01:33:36PM -0500, Thomas Molina wrote:
> [snip explanation of why these are "long-term problems"]

The PCI-PCI bridge stuff shouldn't be terribly difficult to deal with.
qlogicisp.c is just waiting for someone, anyone who has any idea how
the hardware works, and the tasklist_lock setting off the NMI oopser
when you breathe on it NFI. So maybe 1/3 is long-term.


Cheers,
Bill
