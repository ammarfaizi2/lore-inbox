Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290550AbSBKWXo>; Mon, 11 Feb 2002 17:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290551AbSBKWXe>; Mon, 11 Feb 2002 17:23:34 -0500
Received: from panoramix.vasoftware.com ([198.186.202.147]:5580 "EHLO
	mail2.vasoftware.com") by vger.kernel.org with ESMTP
	id <S290550AbSBKWXZ>; Mon, 11 Feb 2002 17:23:25 -0500
Date: Tue, 12 Feb 2002 08:05:14 +1100
From: Anton Blanchard <anton@samba.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Carsten Otte <COTTE@de.ibm.com>,
        rgooch@ras.ucalgary.ca
Subject: Re: [PATCH] linux-2.417 devfs 64bit portablility issue
Message-ID: <20020211210514.GB5401@krispykreme>
In-Reply-To: <OFA3A51DAC.14854039-ONC1256B5D.0045F62F@de.ibm.com> <20020211161259.E21300@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020211161259.E21300@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Isn't it about time we made the bitops take an unsigned long pointer
> argument, rather than a void pointer to catch errors like this?

Davem tried this a while ago (the changes made it into the vger tree)
but I think the number of casts required led to it being removed.

But I do agree, I have found long standing bugs before by changing them
to take an unsigned long.

Anton
