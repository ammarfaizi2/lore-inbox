Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261580AbSJILtu>; Wed, 9 Oct 2002 07:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261581AbSJILtu>; Wed, 9 Oct 2002 07:49:50 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:43535 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S261580AbSJILts>; Wed, 9 Oct 2002 07:49:48 -0400
Date: Wed, 9 Oct 2002 04:55:27 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] silence an unnescessary raid5 debugging message
Message-ID: <20021009115527.GD10333@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20021008180350.A15858@redhat.com> <15779.27330.284336.914423@notabene.cse.unsw.edu.au> <20021008193612.H15858@redhat.com> <20021008.175116.22950725.davem@redhat.com> <20021008210249.I15858@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021008210249.I15858@redhat.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 09:02:49PM -0400, Benjamin LaHaise wrote:
> On Tue, Oct 08, 2002 at 05:51:16PM -0700, David S. Miller wrote:
> >    From: Benjamin LaHaise <bcrl@redhat.com>
> >    Date: Tue, 8 Oct 2002 19:36:12 -0400
> >    
> >    As it stands, the syslogging from the printk does more damage to
> >    performance than the underlying problem.  Besides, LVM snapshots
> >    are slow, but they're useful for a class of problems anyways.
> > 
> > He's just saying kill the real problem first, that's all.
> 
> I'm just saying that the message is the only real problem I have with 
> the state of 2.4.  Sure, 2.5 deserves it fixed correctly, but I doubt 
> the correct fix will make it into 2.4 anytime soon (it's far more 
> dangerous than we should consider shipping in a "stable" series).

It sound to me like a big nasty message should be generated
when the snapshot volume is created to advise that
performance will be horribly impaired.  Thrashing the log
file to warn the user is like breaking your arm to remind
yourself to trim your fingernails.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
