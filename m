Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbTESSgx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 14:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbTESSgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 14:36:53 -0400
Received: from ida.rowland.org ([192.131.102.52]:1796 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262589AbTESSgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 14:36:52 -0400
Date: Mon, 19 May 2003 14:49:49 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Paul Fulghum <paulkf@microgate.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       <johannes@erdfelt.com>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: Test Patch: 2.5.69 Interrupt Latency
In-Reply-To: <1053368413.1995.9.camel@diemos>
Message-ID: <Pine.LNX.4.44L0.0305191448001.631-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 May 2003, Paul Fulghum wrote:

> the patch applied cleanly and worked for me
> (prevented global suspension). Having the lengthy
> waits outside of the ISR is a definate plus, and
> the debounce makes sense.

Good.  I'll submit this, if no other problems arise.

> My machine does not have APM/ACPI facilities so
> I can't test the suspend. It is getting pretty
> dated, but the economy dictates I live with it for
> a while longer :-)
> 
> Does you laptop use the PIIX4? If it does and uses only
> one port, I would be very interested to see if
> one port is continuously reporting OC (hardwired).

I don't remember what chipset it has.  But it definitely includes a UHCI 
controller with only one port.  I'll check it out tonight.

Alan Stern

