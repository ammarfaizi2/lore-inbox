Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265596AbUAGQ6S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 11:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265608AbUAGQ5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 11:57:51 -0500
Received: from main.gmane.org ([80.91.224.249]:62860 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266220AbUAGQ5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 11:57:48 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Slow receive with AX8817 USB2 ethernet adapter
Date: Wed, 07 Jan 2004 17:57:46 +0100
Message-ID: <yw1xekubvgqd.fsf@ford.guide>
References: <yw1xr7ybvpv0.fsf@ford.guide> <yw1xisjnvp9e.fsf@ford.guide>
 <1073490614.5634.31.camel@dhollis-lnx.kpmg.com>
 <1073491990.5634.36.camel@dhollis-lnx.kpmg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:bjY8hzhjsEmbWV1DOUgelrJI3ws=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David T Hollis <dhollis@davehollis.com> writes:

> On Wed, 2004-01-07 at 10:54, David T Hollis wrote:
>> On Wed, 2004-01-07 at 08:53, Måns Rullgård wrote:
>> > mru@kth.se (Måns Rullgård) writes:
>> > 
>> > > I'm getting very bad receive rates with a Netgear FA-120 USB2 Ethernet
>> > > adapter under Linux 2.6.0.  Timing an incoming TCP stream, I get only
>> > > 600 kB/s.  Sending works properly at 10 MB/s.  I first reported this
>> > > problem some time in July or August.  Is it just me having this issue?
>> > > Can I get any helpful information somehow?
>> > 
>> Hmm, I am seeing the same results using ttcp:
>> 
> Some more results.  This time I walked away for a few minutes, came back
> and ran the test again and started getting the 10MB numbers again.  No
> driver unload, etc.  Interesting thing is the I/O calls and time per
> call.  I'm curious as to whether  the varying results are tied to memory
> allocation, locking, or what.

Just a very unscientific observation: my laptop emits a noise when the
ethernet is used.  The pitch depends on the transfer rate.  When
communicating with a working machine, and receiving from the ax8817,
there is a continuous high-pitch sound.  When sending to the ax8817,
the sound has a much lower pitch (not surprising) and is also
intermittent with bursts lasting < 1/2 second followed by an
approximately 1/2 second pause.  The lights on the switch behave
similarly.

-- 
M�ns Rullg�rd
mru@kth.se

