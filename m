Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279144AbRKFMV4>; Tue, 6 Nov 2001 07:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279156AbRKFMVh>; Tue, 6 Nov 2001 07:21:37 -0500
Received: from gap.cco.caltech.edu ([131.215.139.43]:64935 "EHLO
	gap.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S279144AbRKFMV1>; Tue, 6 Nov 2001 07:21:27 -0500
Date: Tue, 6 Nov 2001 12:03:13 +0000
From: Dale Amon <amon@vnl.com>
To: Terje Eggestad <terje.eggestad@scali.no>
Cc: weixl@caltech.edu, mlist-linux-kernel@nntp-server.caltech.edu
Subject: Re: How can I know the number of current users in the system?
Message-ID: <20011106120313.F8359@vnl.com>
In-Reply-To: <3BE5BDFB.B49A8147@caltech.edu> <1005038940.2134.27.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1005038940.2134.27.camel@pc-16.office.scali.no>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2001 at 10:28:57AM +0100, Terje Eggestad wrote:
> 
> My suggestion is to loop thru the processes and collect a list of all
> the userids and form a tree/list of all the processes belonging to each
> of them. Then you fair share schedule between the users.

Hmmm, you should be able to count the number of pty's and tty's.
Every logged in user is attached to some sort of getty
whose parent is the init task (1). That might be a basis for
a count.

-- 
------------------------------------------------------
    Nuke bin Laden:           Dale Amon, CEO/MD
  improve the global          Islandone Society
     gene pool.               www.islandone.org
------------------------------------------------------
