Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132042AbRCYPq3>; Sun, 25 Mar 2001 10:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132044AbRCYPqT>; Sun, 25 Mar 2001 10:46:19 -0500
Received: from [195.63.194.11] ([195.63.194.11]:29201 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S132042AbRCYPqC>; Sun, 25 Mar 2001 10:46:02 -0500
Message-ID: <3ABE0F32.5255DF30@evision-ventures.com>
Date: Sun, 25 Mar 2001 17:30:58 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "James A. Sutherland" <jas88@cam.ac.uk>,
        Guest section DW <dwguest@win.tue.nl>,
        Rik van Riel <riel@conectiva.com.br>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <E14gVQf-00056B-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > That depends what you mean by "must not". If it's your missile guidance
> > system, aircraft autopilot or life support system, the system must not run
> > out of memory in the first place. If the system breaks down badly, killing
> > init and thus panicking (hence rebooting, if the system is set up that
> > way) seems the best approach.
> 
> Ultra reliable systems dont contain memory allocators. There are good reasons
> for this but the design trade offs are rather hard to make in a real world
> environment

I esp. they run on CPU's without a stack or what?
