Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262230AbUKKMpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbUKKMpV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 07:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbUKKMpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 07:45:21 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:13007 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262230AbUKKMpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 07:45:14 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm5: yenta_socket issue
Date: Thu, 11 Nov 2004 13:43:48 +0100
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>
References: <20041111012333.1b529478.akpm@osdl.org> <200411111311.44664.rjw@sisk.pl> <20041111042130.161d2c28.akpm@osdl.org>
In-Reply-To: <20041111042130.161d2c28.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200411111343.48010.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 of November 2004 13:21, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > On Thursday 11 of November 2004 10:23, Andrew Morton wrote:
> > > 
> > > 
> > 
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm5/
> > 
> > On an AMD64 box (Athlon 64 + NForce3) I get these messages from 
yenta_socket:
> > 
> > yenta_socket: Unknown symbol dead_socket
> > yenta_socket: Unknown symbol pcmcia_register_socket
> > yenta_socket: Unknown symbol pcmcia_socket_dev_resume
> > yenta_socket: Unknown symbol pcmcia_parse_events
> > yenta_socket: Unknown symbol pcmcia_socket_dev_suspend
> > yenta_socket: Unknown symbol pcmcia_unregister_socket
> > 
> 
> hm, I haven't seen that before.  Rusty, any ideas what we might have done
> to provoke this?

I have just searched my logs.  It was there in 2.6.8.1 and went away in 
2.6.9-rc1-mm5.  Then, it reappeared in 2.6.10-rc1-mm2 (I didn't notice) and 
it's been there since.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
