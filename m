Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262084AbVATJTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbVATJTb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 04:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbVATJTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 04:19:31 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:4523 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262084AbVATJT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 04:19:28 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Jenkins <aj504@student.cs.york.ac.uk>
Subject: Re: 2.6.9 suspend-to-disk bug (during resume)
Date: Thu, 20 Jan 2005 10:19:24 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <1106210882.7975.9.camel@linux.site> <1106210985l.8224l.0l@linux>
In-Reply-To: <1106210985l.8224l.0l@linux>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501201019.24378.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 20 of January 2005 09:49, Alan Jenkins wrote:
> On 20/01/05 08:48:02, Alan Jenkins wrote:
> I have noticed a similar message, and so has someone else on the list:
> 
> http://groups-beta.google.com/group/fa.linux.kernel/browse_thread/thread/1bfcbbca2d508bb3/cb69d674510d215a?q=%22bad:+scheduling+while+atomic!%22+suspend&_done=%2Fgroup%2Ffa.linux.kernel%2Fsearch%3Fgroup%3Dfa.linux.kernel%26q%3D%22bad:+scheduling+while+atomic!%22+suspend%26qt_g%3D1%26searchnow%3DSearch+this+group%26&_doneTitle=Back+to+Search&&d#cb69d674510d215a
> 
> I have an asrock motherboard with an sis chipset.
> SiS seems to be the common factor.  I think its something general about
> the chipset.  My messages seem to involve the network card, the sound
> card and the i8042 (ps/2 port) controller:

Have you tried to boot with "pci=routeirq" or/and "noapic"?

Greets,
RJW


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
