Return-Path: <linux-kernel-owner+w=401wt.eu-S1761248AbWLINd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761248AbWLINd1 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 08:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761247AbWLINd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 08:33:27 -0500
Received: from web57808.mail.re3.yahoo.com ([68.142.236.86]:43013 "HELO
	web57808.mail.re3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1761248AbWLINd1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 08:33:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=fkYm5yGDBvb6KeLemrEAeYjGkjewDO0XCnQuXLg25UF7eV7UJPU97RaMXgRRWFIh2QtJCPz8/xyTGeR8Lu3gqpXPSwLwLHqxqgTkyxPR4X5sPvSemj04RHUAAj4AZgpwXH8UNR4ninO3uJI0GbPDdEty5oPLchsy5cXwYgFqrAQ=  ;
Message-ID: <20061209133326.69944.qmail@web57808.mail.re3.yahoo.com>
Date: Sat, 9 Dec 2006 05:33:26 -0800 (PST)
From: Rakhesh Sasidharan <rakheshster@yahoo.com>
Reply-To: Rakhesh Sasidharan <rakhesh@rakhesh.com>
Subject: Re: VCD not readable under 2.6.18
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Slackware 11 (2.6.18 kernel) didn't have GNOME installed. So if it is a GNOME thing, how come Slackware too was giving the same error? 

Also, if previously the kernel wasn't reporting errors when asked to do stuff like this with VCDs, how come it was still able to mount the VCDs and allow playback/ copying of the files in it? Its ok if the kernel reports more errors than before, as long as it allows playback/ copying ... 

Regards,
Rakhesh

ps. Please do cc me on replies to thread. 

----- Original Message ----
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Rakhesh Sasidharan <rakhesh@rakhesh.com>
Cc: rakheshster@yahoo.com; linux-kernel@vger.kernel.org
Sent: Saturday, December 9, 2006 5:21:20 PM
Subject: Re: VCD not readable under 2.6.18


Your system tried to read a Video data block. The usual cure for this
problem is to remove Gnome, or at least kill all the Gnome stuff and flip
to init level 3 then mount the cd from the command line. 

The kernel is correctly reporting it was asked to do something stupid.
Older kernels would fail to report many of these errors due to a bug in
the ide-cd reporting logic.






 
____________________________________________________________________________________
Any questions? Get answers on any topic at www.Answers.yahoo.com.  Try it now.
