Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265761AbSJYAfH>; Thu, 24 Oct 2002 20:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265758AbSJYAfH>; Thu, 24 Oct 2002 20:35:07 -0400
Received: from sccrmhc03.attbi.com ([204.127.202.63]:36227 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S265759AbSJYAeF>; Thu, 24 Oct 2002 20:34:05 -0400
Date: Thu, 24 Oct 2002 17:40:13 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: "Leech, Christopher" <christopher.leech@intel.com>
Cc: "'Jeff Garzik'" <jgarzik@pobox.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCI device order problem
Message-ID: <20021024174013.B23457@lucon.org>
References: <BD9B60A108C4D511AAA10002A50708F2073175F7@orsmsx118.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <BD9B60A108C4D511AAA10002A50708F2073175F7@orsmsx118.jf.intel.com>; from christopher.leech@intel.com on Thu, Oct 24, 2002 at 05:21:10PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 05:21:10PM -0700, Leech, Christopher wrote:
> I've heard some grumbling about this with specific motherboards and 82546
> LOMs. While I understand what's happening, and that using nameif to manage
> this is the correct answer, I am a bit surprised that function 1 would be
> placed on the global PCI device list before function 0 for a multi-function
> device.
> 

You can tell it from the BIOS, which lists 0339 before 0338 by default.


H.J.
