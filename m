Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313537AbSFGBd4>; Thu, 6 Jun 2002 21:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314707AbSFGBdz>; Thu, 6 Jun 2002 21:33:55 -0400
Received: from rj.SGI.COM ([192.82.208.96]:63443 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S313537AbSFGBdz>;
	Thu, 6 Jun 2002 21:33:55 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Panic from 2.4.19-pre9-aa2 
In-Reply-To: Your message of "Thu, 06 Jun 2002 14:53:40 MST."
             <83910000.1023400420@flay> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 07 Jun 2002 11:33:43 +1000
Message-ID: <10173.1023413623@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jun 2002 14:53:40 -0700, 
"Martin J. Bligh" <Martin.Bligh@us.ibm.com> wrote:
>Not sure why ksymoops is printing c0147dac from the trace, whilst 
>the stack says c0147dad, which seems to be the schedule call - 
>would make sense, as that's what you just changed?

Truncate mask bug, fixed in ksymoops 2.4.4.  Current is 2.4.5.

