Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290667AbSARKVr>; Fri, 18 Jan 2002 05:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290656AbSARKVh>; Fri, 18 Jan 2002 05:21:37 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:26120 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S290667AbSARKVX>; Fri, 18 Jan 2002 05:21:23 -0500
Message-ID: <3C47F716.A192DB3F@aitel.hist.no>
Date: Fri, 18 Jan 2002 11:21:10 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.2-pre11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
Subject: Re: o(1) to the rescue
In-Reply-To: <20020118030630.AA34757D57@oscar.casa.dyndns.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson wrote:
> 
> Try this with and without the o(1) scheduler (J0).
> 
> Create a dir full of 1 meg or so jpegs.  Fire up kde.  Try using the
> Tools/Create image gallery.
> With the standard scheduler linux is unusable - it stalls for most of the
> processing time for
> each image.   With o(1) its just a little jerky - still usable though (a
> gallery is building as I
> type this).

I guess this thing starts a thread per image?  That would
give a lot of _running_ processes, which is exactly what
the O(1) scheduler improves.

Helge Hafting
