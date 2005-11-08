Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030371AbVKHVdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030371AbVKHVdT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 16:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030370AbVKHVdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 16:33:18 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:5307 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030365AbVKHVdR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 16:33:17 -0500
Date: Tue, 8 Nov 2005 13:33:06 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: "goggin, edward" <egoggin@emc.com>,
       "'Rolf Eike Beer'" <eike-kernel@sf-tec.de>,
       "'Andrew Morton'" <akpm@osdl.org>,
       Masanari Iida <standby24x7@gmail.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, linux-scsi@vger.kernel.org
Subject: Re: oops with USB Storage on 2.6.14
Message-ID: <20051108213306.GA25219@us.ibm.com>
References: <C2EEB4E538D3DC48BF57F391F422779321ADC0@srmanning.eng.emc.com> <1131484123.3270.36.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131484123.3270.36.camel@mulgrave>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 04:08:43PM -0500, James Bottomley wrote:
> On Tue, 2005-11-08 at 15:02 -0500, goggin, edward wrote:
> > Thanks!  Here's a better one.
> 
> It's line wrapped, but I fixed that up.

What code path triggered this?

I mean we get a ref to the sdev in the upper level driver opens, scan, and
sd flush. So where are we not getting a ref? 

Shouldn't the get be done at a higher level?

-- Patrick Mansfield
