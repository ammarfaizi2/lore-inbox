Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289834AbSBKQNe>; Mon, 11 Feb 2002 11:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289837AbSBKQNO>; Mon, 11 Feb 2002 11:13:14 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:59655 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S289834AbSBKQNJ>; Mon, 11 Feb 2002 11:13:09 -0500
Date: Mon, 11 Feb 2002 16:12:59 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Cc: Carsten Otte <COTTE@de.ibm.com>, rgooch@ras.ucalgary.ca
Subject: Re: [PATCH] linux-2.417 devfs 64bit portablility issue
Message-ID: <20020211161259.E21300@flint.arm.linux.org.uk>
In-Reply-To: <OFA3A51DAC.14854039-ONC1256B5D.0045F62F@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OFA3A51DAC.14854039-ONC1256B5D.0045F62F@de.ibm.com>; from COTTE@de.ibm.com on Mon, Feb 11, 2002 at 02:00:06PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2002 at 02:00:06PM +0100, Carsten Otte wrote:
> Afterwards, the block_major_list.bits is processed using
> find_first_zero_bit & set_bit out of asm/bitops.h.

Isn't it about time we made the bitops take an unsigned long pointer
argument, rather than a void pointer to catch errors like this?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

