Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263235AbTCNDpd>; Thu, 13 Mar 2003 22:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263237AbTCNDpd>; Thu, 13 Mar 2003 22:45:33 -0500
Received: from sdfw-ext.castandcrew.com ([63.113.17.130]:21496 "EHLO
	sddev.castandcrew.com") by vger.kernel.org with ESMTP
	id <S263235AbTCNDpc>; Thu, 13 Mar 2003 22:45:32 -0500
From: "Gregory K. Ruiz-Ade" <gregory@castandcrew.com>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.20 instability on bigmem systems?
Date: Thu, 13 Mar 2003 19:55:27 -0800
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200303131627.22572.gregory@castandcrew.com> <200303131745.28683.gregory@castandcrew.com> <20030314015346.GJ20188@holomorphy.com>
In-Reply-To: <20030314015346.GJ20188@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303131955.27060.gregory@castandcrew.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 March 2003 17:53, William Lee Irwin III wrote:
> On Thursday 13 March 2003 16:42, William Lee Irwin III wrote:
> >> Hmm, slabinfo would be very helpful, as well as meminfo.
>
> On Thu, Mar 13, 2003 at 05:45:28PM -0800, Gregory K. Ruiz-Ade wrote:
> > I'll have to schedule a reboot into that kernel, but I'll try to get it
> > tonight if at all possible.
>
> That's fine; I'm not in a hurry. =)

I got an opportunity, so the contents of cpuinfo, slabinfo, and meminfo are 
at: http://castandcrew.com/~gregory/lkmlstuff/burpr/2.4.20

Hopefully they're useful.

Additionally, I managed to generate an Oops (processed with ksymoops, too) 
while trying to create an LVM snapshot.  The oops and it's 
ksymoops-translated file are up there too.  The oops traces back into the 
VM somewhere.

-- 
Gregory K. Ruiz-Ade <gregory@castandcrew.com>
Sr. Systems Administrator
Cast & Crew Entertainment Services, Inc.

