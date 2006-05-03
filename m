Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWECTXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWECTXc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 15:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWECTXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 15:23:32 -0400
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:16280 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750744AbWECTXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 15:23:32 -0400
From: David Brownell <david-b@pacbell.net>
To: David Hollis <dhollis@davehollis.com>
Subject: Re: [linux-usb-devel] New, yet unsupported USB-Ethernet adaptor
Date: Wed, 3 May 2006 12:23:24 -0700
User-Agent: KMail/1.7.1
Cc: Michael Helmling <supermihi@web.de>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <200605022002.15845.supermihi@web.de> <1146667488.2348.28.camel@dhollis-lnx.sunera.com> <200605031210.35865.david-b@pacbell.net>
In-Reply-To: <200605031210.35865.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605031223.25840.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 May 2006 12:10 pm, David Brownell wrote:

> Well, it's always allowed driver modularization ... the change was only
> to move the hardware-specific parts outside of the driver core.

Bad wording there.  Last September I submitted patches to split out
the driver core and the hardware-specific parts into separate source
and object modules ... the core was always separate from the parts
applying to specific hardware.  (As you know, since you adopted that
approach for your ASIX code.)  What changed was the "one big file"
model, which had stopped making sense.

- Dave
