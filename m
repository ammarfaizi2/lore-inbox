Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137126AbRA1OeN>; Sun, 28 Jan 2001 09:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137210AbRA1OeC>; Sun, 28 Jan 2001 09:34:02 -0500
Received: from ncc1701.cistron.net ([195.64.68.38]:4103 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S137126AbRA1Odv>; Sun, 28 Jan 2001 09:33:51 -0500
From: miquels@traveler.cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: ECN: Clearing the air (fwd)
Date: Sun, 28 Jan 2001 14:34:44 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <951am4$gbf$1@ncc1701.cistron.net>
In-Reply-To: <Pine.GSO.4.30.0101280700580.24762-100000@shell.cyberus.ca> <Pine.SOL.4.21.0101281324210.26837-100000@yellow.csi.cam.ac.uk>
X-Trace: ncc1701.cistron.net 980692484 16751 195.64.65.67 (28 Jan 2001 14:34:44 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: miquels@traveler.cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.SOL.4.21.0101281324210.26837-100000@yellow.csi.cam.ac.uk>,
James Sutherland  <jas88@cam.ac.uk> wrote:
>On Sun, 28 Jan 2001, jamal wrote:
>> The internet is a form of organized chaos, sometimes you gotta make
>> these type of decisions to get things done. Imagine the joy _most_
>> people would get flogging all firewall admins who block all ICMP.
>
>Blocking out ICMP doesn't bother me particularly. I know they should be
>selective, but it doesn't break anything essential.

It breaks Path MTU Discovery. If you have a link somewhere in your
network (not at an endpoint, or TCP MSS will take care of it) that
has an MTU < 1500, you cannot reach hotmail and a lot of other sites
either currently. It _does_ break essential things. Daily. I would
get a lot of joy from flogging all firewall admins who block all ICMP.

Mike.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
