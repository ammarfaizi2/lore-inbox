Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267284AbSLELJZ>; Thu, 5 Dec 2002 06:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267286AbSLELJZ>; Thu, 5 Dec 2002 06:09:25 -0500
Received: from holomorphy.com ([66.224.33.161]:12938 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267284AbSLELJY>;
	Thu, 5 Dec 2002 06:09:24 -0500
Date: Thu, 5 Dec 2002 03:16:47 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Miles Bader <miles@gnu.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation
Message-ID: <20021205111647.GI9882@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Miles Bader <miles@gnu.org>, linux-kernel@vger.kernel.org
References: <200212042146.gB4Lkw804422@localhost.localdomain> <1039086930.1609.71.camel@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039086930.1609.71.camel@zion>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 12:15:30PM +0100, Benjamin Herrenschmidt wrote:
> Actually, the device model defines a bus "type" structure rather than a
> "bus instance" structure (well, at least it did last I looked a couple
> of weeks ago). That's a problem I beleive here, as those functions are
> really a property of a given bus instance. One solution would eventually
> be to have the set of functions pointers in the generic struct device
> and by default be copied from parent to child.

On an unrelated note, a "bus instance" structure would seem to be
required for proper handling of bridges in combination with PCI segments.


Bill
