Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131607AbRCXHyW>; Sat, 24 Mar 2001 02:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131609AbRCXHyM>; Sat, 24 Mar 2001 02:54:12 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:59284 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S131607AbRCXHyB>; Sat, 24 Mar 2001 02:54:01 -0500
Message-ID: <3ABC5220.37C41DCE@redhat.com>
Date: Sat, 24 Mar 2001 02:52:00 -0500
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "James A. Sutherland" <jas88@cam.ac.uk>
CC: Guest section DW <dwguest@win.tue.nl>,
        Rik van Riel <riel@conectiva.com.br>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <Pine.LNX.4.30.0103231721480.4103-100000@dax.joh.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"James A. Sutherland" wrote:
> On Thu, 22 Mar 2001, Guest section DW wrote:
> > (I think 2.4.0.)
> >
> > Clearly, Linux cannot be reliable if any process can be killed
> > at any moment.
> 
> What on earth did you expect to happen when the process exceeded the
> machine's capabilities? Using more than all the resources fails. There
> isn't an alternative.

You might be successful in convincing myself or Andries of this as soon as the
oom killer only kills things when the system is really out of memory.  Right
now, it's not really an oom killer, it's more like an "I'm Too Lazy To Free Up
Some More Pages So Now You Die" (ITLTFUSMPSNYD) killer.

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
