Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269718AbRIDWyM>; Tue, 4 Sep 2001 18:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269777AbRIDWyC>; Tue, 4 Sep 2001 18:54:02 -0400
Received: from mx1.afara.com ([63.113.218.20]:61913 "EHLO afara-gw.afara.com")
	by vger.kernel.org with ESMTP id <S269718AbRIDWxt>;
	Tue, 4 Sep 2001 18:53:49 -0400
Subject: Re: Applying multiple patches
From: Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>
To: "Elgar, Jeremy" <JElgar@ndsuk.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F128989C2E99D4119C110002A507409801555FD8@topper.hrow.ndsuk.com>
In-Reply-To: <F128989C2E99D4119C110002A507409801555FD8@topper.hrow.ndsuk.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.21.23.41 (Preview Release)
Date: 04 Sep 2001 15:53:52 -0700
Message-Id: <999644032.17558.20.camel@tduffy-lnx.afara.com>
Mime-Version: 1.0
X-OriginalArrivalTime: 04 Sep 2001 22:49:47.0343 (UTC) FILETIME=[E5B58DF0:01C13593]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-09-04 at 06:07, Elgar, Jeremy wrote:

> The problem I have is thus,  I want to apply patch-2.4.9-ac6 (I guess might
> as well do ac7 now) and the xfs patch
> but both are from a vanilla 2-4-9.

I would suggest not trying this out as your first patch conflict fix
attempt.  Both xfs and ac are large and touch a bunch of core linux
files.  Getting xfs to apply on top of ac requires an intimate knowledge
of the xfs (and some ac) code.  If you are interested in trying out, see
how it was done for the 2.4.3-SGI_XFS_1.0.1 rpm that SGI put out for
xfs-enabled redhat 7.1.

If you download the src.rpm from oss.sgi.com/projects/xfs, you will find
an xfs patch that applies on an ac patch.  Now, both xfs and ac have
changed a bunch from the 2.4.3 days, but this will give you a good start
at figuring out what was done to get the two to play nice together.

-tduffy


