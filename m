Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143554AbRA1Qo7>; Sun, 28 Jan 2001 11:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143524AbRA1Qot>; Sun, 28 Jan 2001 11:44:49 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:49069 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S143554AbRA1Qob>; Sun, 28 Jan 2001 11:44:31 -0500
Date: Sun, 28 Jan 2001 16:44:18 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Miquel van Smoorenburg <miquels@traveler.cistron-office.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: ECN: Clearing the air (fwd)
In-Reply-To: <951am4$gbf$1@ncc1701.cistron.net>
Message-ID: <Pine.SOL.4.21.0101281642180.16734-100000@green.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jan 2001, Miquel van Smoorenburg wrote:

> In article <Pine.SOL.4.21.0101281324210.26837-100000@yellow.csi.cam.ac.uk>,
> James Sutherland  <jas88@cam.ac.uk> wrote:
> >On Sun, 28 Jan 2001, jamal wrote:
> >> The internet is a form of organized chaos, sometimes you gotta make
> >> these type of decisions to get things done. Imagine the joy _most_
> >> people would get flogging all firewall admins who block all ICMP.
> >
> >Blocking out ICMP doesn't bother me particularly. I know they should be
> >selective, but it doesn't break anything essential.
> 
> It breaks Path MTU Discovery. If you have a link somewhere in your
> network (not at an endpoint, or TCP MSS will take care of it) that
> has an MTU < 1500, you cannot reach hotmail and a lot of other sites
> either currently. It _does_ break essential things. Daily. I would
> get a lot of joy from flogging all firewall admins who block all ICMP.

Except you can detect and deal with these "PMTU black holes". Just as you
should detect and deal with ECN black holes. Maybe an ideal Internet
wouldn't have them, but this one does. If you can find an ideal Internet,
go code for it: until then, stick with the real one. It's all we've got.


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
