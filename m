Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285633AbRLSXvm>; Wed, 19 Dec 2001 18:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285644AbRLSXvc>; Wed, 19 Dec 2001 18:51:32 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:29429 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S285633AbRLSXvP>; Wed, 19 Dec 2001 18:51:15 -0500
Date: Wed, 19 Dec 2001 15:50:20 -0800
From: Chris Wright <chris@wirex.com>
To: Jason Czerak <Jason-Czerak@Jasnik.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suggestions for linux security patches
Message-ID: <20011219155020.A4424@figure1.int.wirex.com>
Mail-Followup-To: Jason Czerak <Jason-Czerak@Jasnik.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1008794926.842.6.camel@neworder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1008794926.842.6.camel@neworder>; from Jason-Czerak@Jasnik.net on Wed, Dec 19, 2001 at 03:48:46PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jason Czerak (Jason-Czerak@Jasnik.net) wrote:
> So to advoid applying 20 or so differnet patches, and evaluate each of
> them (taking up what little time I have in a day...), I wish to get the
> lists opinions on the matter.

have you looked at linux security modules?  the patches are at
http://lsm.immunix.org.  it pushes security policy into modules so you can
try different modules to see which policy you prefer.

> Local security/control isn't much of an issue and most likly won't be
> for a while. Remote security and protection from server deamons that
> have buffer problems are high priority to get the best protection for. 

note, non-executable stack does not prevent buffer overflow attacks.
the exploit just needs to change.  check out tools like libsafe and
StackGuard as well for buffer overflow protection.

thanks,
-chris
