Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283938AbRLJWhj>; Mon, 10 Dec 2001 17:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284516AbRLJWh2>; Mon, 10 Dec 2001 17:37:28 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:36760 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S283938AbRLJWhR>; Mon, 10 Dec 2001 17:37:17 -0500
Date: Mon, 10 Dec 2001 17:37:11 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Ben Greear <greearb@candelatech.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Paul P Komkoff Jr <i@stingr.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MTU vlan-related patch for tulip (2.4.x)
Message-ID: <20011210173710.C3323@redhat.com>
In-Reply-To: <20011210225759.B11450@stingr.net> <3C15146D.BA780B43@mandrakesoft.com> <3C1515E6.9C6EC26@mandrakesoft.com> <3C15197C.7050708@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C15197C.7050708@candelatech.com>; from greearb@candelatech.com on Mon, Dec 10, 2001 at 01:22:20PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2001 at 01:22:20PM -0700, Ben Greear wrote:
> I think Becker once told me that there was no need to increase
> the 1536 number (it is already plenty big, and has some extra space
> in it already)...

You are correct: standard ethernet packet size is 1500 + 6 + 6 + 4 if 
the crc is included.  Of course, some drivers use part of the memory 
in the packet for the rx descriptor....

		-ben
