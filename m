Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262474AbUJ0O6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbUJ0O6w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 10:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262475AbUJ0O6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 10:58:51 -0400
Received: from thunk.org ([69.25.196.29]:59838 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262474AbUJ0O6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 10:58:33 -0400
Date: Wed, 27 Oct 2004 10:57:45 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: John Richard Moser <nigelenki@comcast.net>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Willy Tarreau <willy@w.ods.org>, Rik van Riel <riel@redhat.com>,
       "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       Ed Tomlinson <edt@aei.ca>, Massimo Cetra <mcetra@navynet.it>,
       "'Chuck Ebbert'" <76306.1226@compuserve.com>,
       "'Bill Davidsen'" <davidsen@tmr.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: My thoughts on the "new development model"
Message-ID: <20041027145743.GA16666@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	John Richard Moser <nigelenki@comcast.net>,
	William Lee Irwin III <wli@holomorphy.com>,
	Willy Tarreau <willy@w.ods.org>, Rik van Riel <riel@redhat.com>,
	"Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
	Ed Tomlinson <edt@aei.ca>, Massimo Cetra <mcetra@navynet.it>,
	'Chuck Ebbert' <76306.1226@compuserve.com>,
	'Bill Davidsen' <davidsen@tmr.com>,
	'linux-kernel' <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0410270402340.20284@student.dei.uc.pt> <Pine.LNX.4.44.0410270027110.21548-100000@chimarrao.boston.redhat.com> <20041027051342.GK19761@alpha.home.local> <20041027052321.GT15367@holomorphy.com> <417FA711.90700@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417FA711.90700@comcast.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 09:48:01AM -0400, John Richard Moser wrote:
> 
> I for one don't give a damn.  Bugs and how fast this development model
> fix them aren't a concern to me; although I'd never slow down the bug
> fixing process.  My concern is getting a real stable tree for various
> maintainers to base on, so that various patches for drivers, security
> enhancements, and other things aren't scattered across versions and
> impossible to patch together even when they're noninvasive to eachother.
> 
> Have you stopped to consider that the features that are critical to me
> are also holding me back from upgrading to the newer kernels?
> Ironically, these are security features, and the newer kernels have
> newer security fixes aside from new schedulers and other toys I could
> really enjoy having around.

So instead of kvetching, why don't you 

(a) Create your own stable series by snapshotting some 2.6.x tree
every six months, and then maintain a set of bug-fix only patches
against that 2.6.x tree?  Then convince the security people to port to
that particular 2.6.x-jrm tree?

(b) Convince the security folks to try to get their patches into the
mm- tree, for eventual inclusion into 2.6.

(c) Some combination of the two.

Either would probably be more likely to fulfill your needs than just
whining about it.

						- Ted
