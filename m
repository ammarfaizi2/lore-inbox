Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264104AbTLUTei (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 14:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264106AbTLUTei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 14:34:38 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:16271 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S264104AbTLUTea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 14:34:30 -0500
To: Ben Collins <bcollins@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Firewire/sbp2 troubles with Linux 2.6.0
References: <yw1x8yl66ecs.fsf@ford.guide>
	<20031221035348.GM6607@phunnypharm.org> <yw1x4qvumozm.fsf@ford.guide>
	<20031221144813.GN6607@phunnypharm.org> <yw1xn09mkvs9.fsf@ford.guide>
	<20031221183132.GP6607@phunnypharm.org> <yw1x4qvu6l9g.fsf@ford.guide>
	<20031221184840.GR6607@phunnypharm.org>
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Sun, 21 Dec 2003 20:34:28 +0100
In-Reply-To: <20031221184840.GR6607@phunnypharm.org> (Ben Collins's message
 of: 48:40 -0500")
Message-ID: <yw1xzndm55iz.fsf@ford.guide>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins <bcollins@debian.org> writes:

>> > As far as 10mbs, you have to remember that even though firewire is much
>> > higher than that, your drive is still an IDE, and the firewire is still
>> > going through an IDE bridge. So the limitation lies in the IDE bridge.
>> > I've seen performance as high as 34MB/s with good IDE bridges and
>> > drives, though.
>> 
>> The disks will easily do 40 MB/s on a good IDE controller.  It seems
>> like a rather bad bridge to me if it has that much overhead.  I
>> haven't seen many different options for sale, either.
>
> Most things based on newer Oxford chips seem to work pretty well. What
> ohci1394 controller do you have though?

I have this:

00:0a.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 1687
        Flags: bus master, medium devsel, latency 32, IRQ 11
        Memory at e5800000 (32-bit, non-prefetchable) [size=2K]
        Capabilities: <available only to root>

-- 
Måns Rullgård
mru@kth.se
