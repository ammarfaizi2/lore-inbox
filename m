Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276256AbRI1Tet>; Fri, 28 Sep 2001 15:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276257AbRI1Tej>; Fri, 28 Sep 2001 15:34:39 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:51695
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S276256AbRI1Ted>; Fri, 28 Sep 2001 15:34:33 -0400
Date: Fri, 28 Sep 2001 12:34:55 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Tools better than vmstat [was: 2.4.9-ac16 good perfomer?]
Message-ID: <20010928123455.B8222@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200109281826.f8SIQLP06585@deathstar.prodigy.com> <Pine.LNX.4.33L.0109281535220.26495-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0109281535220.26495-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2001 at 03:36:33PM -0300, Rik van Riel wrote:
> On Fri, 28 Sep 2001, bill davidsen wrote:
> > seems okay but not wildly better, my aim was to be able to use netscape
> > and cdrecord and {anything_else} at the same time.
> 
> Mmmm, interesting.  Could you send me a screen worth of
> top output and maybe 10 or 20 lines or so of 'vmstat 1'
> output, both taken while the machine is going through a
> hard time ?
> 
> Lets try to resolve this issue while we're at it ;)
> 
> Rik

Rik,

It seems to me that while you can get good information about the VM from
vmstat, it doesn't really give enough detail.

It doesn't give any info about the ages of pages, or anything detailed besides
sizes of memory caches, and amount of swaping.

I read not too long ago about someone mentioning a patch that lists the ages
of pages via a proc interface...

Does anything like this interest you?
