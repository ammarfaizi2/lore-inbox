Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285135AbRLRFLg>; Tue, 18 Dec 2001 00:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285137AbRLRFL0>; Tue, 18 Dec 2001 00:11:26 -0500
Received: from hokua.cfht.hawaii.edu ([128.171.80.51]:24818 "EHLO
	hokua.cfht.hawaii.edu") by vger.kernel.org with ESMTP
	id <S285135AbRLRFLO>; Tue, 18 Dec 2001 00:11:14 -0500
From: Thierry Forveille <forveill@cfht.hawaii.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15390.53230.827019.336771@hoku.cfht.hawaii.edu>
Date: Mon, 17 Dec 2001 19:11:10 -1000 (HST)
To: linux-kernel@vger.kernel.org
Subject: Re: Scheduler ( was: Just a second ) ...
X-Mailer: VM 6.75 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds (torvalds@transmeta.com) writes
> On Mon, 17 Dec 2001, Rik van Riel wrote:
> >
> > Try readprofile some day, chances are schedule() is pretty
> > near the top of the list.
>
> Ehh.. Of course I do readprofile.
>  
> But did you ever compare readprofile output to _total_ cycles spent?
>
I have a feeling that this discussion got sidetracked: cpu cycles burnt 
in the scheduler indeed is non-issue, but big tasks being needlessly moved
around on SMPs is worth tackling.
