Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272046AbTGYMmU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 08:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272048AbTGYMmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 08:42:20 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:7092 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S272046AbTGYMmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 08:42:19 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16161.10551.426528.975130@laputa.namesys.com>
Date: Fri, 25 Jul 2003 16:57:27 +0400
To: Tupshin Harper <tupshin@tupshin.com>
Cc: Daniel Egger <degger@fhm.edu>, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org,
       reiserfs mailing list <reiserfs-list@namesys.com>
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
In-Reply-To: <3F204B3B.3040802@tupshin.com>
References: <3F1EF7DB.2010805@namesys.com>
	<1059062380.29238.260.camel@sonja>
	<16160.4704.102110.352311@laputa.namesys.com>
	<3F204B3B.3040802@tupshin.com>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tupshin Harper writes:
 > Nikita Danilov wrote:
 > 
 > >Daniel Egger writes:
 > > > 
 > > > How failsafe is it to switch off the power several times? When the
 > > > filesystem really works atomically I should have either the old or the
 > > > new version but no mixture. Does it still need to fsck or is the
 > > > transaction replay done at mount time? In case one still needs fsck,
 > > > what's the probability of needing user interaction? How long does it
 > > > need to get a filesystem back into a consistent state after a powerloss
 > > > (approx. per MB/GB)?
 > >
 > >I should warn everybody that reiser4 is _highly_ _experimental_ at this
 > >moment. Don't use it for production.
 > >
 > I'd like to ask this question differently: How failsafe is reiserfs4 
 > *theoretically*. Assuming no bugs in implementation, what is the true 
 > import of its atomic nature? Strengths and potential weaknesses?

Assuming no bugs in implementation it is very safe. :-)

This is lengthy topic. You may wish to read documents on the
namesys.com. For example,

http://www.namesys.com/v4/reiser4_the_atomic_fs.html

 > 
 > -Thanks
 > -Tupshin
 > 

Nikita.
