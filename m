Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287317AbSA1Wza>; Mon, 28 Jan 2002 17:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287333AbSA1WzT>; Mon, 28 Jan 2002 17:55:19 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:41377 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S287317AbSA1WzC>;
	Mon, 28 Jan 2002 17:55:02 -0500
Date: Mon, 28 Jan 2002 22:46:33 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        reiserfs-dev@namesys.com,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: Note describing poor dcache utilization under high memory
 pressure
Message-ID: <1320036695.1012257992@[195.224.237.69]>
In-Reply-To: <Pine.LNX.4.33.0201280930130.1557-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0201280930130.1557-100000@penguin.transmeta.com>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Monday, 28 January, 2002 9:39 AM -0800 Linus Torvalds 
<torvalds@transmeta.com> wrote:

> Thus any slab user that wants to, could just register their own per-page
> memory pressure logic.

It might be useful to use a similar type interface to aid
in defragmentation - i.e. 'relocate the stuff on this
(physical) page please, I want it back'. If nothing is
registered, the default mechanism could be just to free it
a la writepage().

--
Alex Bligh
