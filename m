Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbVGEBdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbVGEBdX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 21:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbVGEBcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 21:32:53 -0400
Received: from smtp102.rog.mail.re2.yahoo.com ([206.190.36.80]:12376 "HELO
	smtp102.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261753AbVGEBcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 21:32:25 -0400
Subject: Re: Problem with inotify
From: John McCutchan <ttb@tentacle.dhs.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Daniel Drake <dsd@gentoo.org>,
       David =?ISO-8859-1?Q?G=F3mez?= <david@pleyades.net>,
       Robert Love <rml@novell.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.60.0507042008310.7572@hermes-1.csi.cam.ac.uk>
References: <20050630181824.GA1058@fargo> <1120156188.6745.103.camel@betsy>
	 <20050630193320.GA1136@fargo>
	 <Pine.LNX.4.60.0506302138230.29755@hermes-1.csi.cam.ac.uk>
	 <20050630204832.GA3854@fargo>
	 <Pine.LNX.4.60.0506302158190.29755@hermes-1.csi.cam.ac.uk>
	 <42C65A8B.9060705@gentoo.org>
	 <Pine.LNX.4.60.0507022253080.30401@hermes-1.csi.cam.ac.uk>
	 <42C72563.7040103@gentoo.org>
	 <Pine.LNX.4.60.0507030053040.15398@hermes-1.csi.cam.ac.uk>
	 <42C7BF37.9010005@gentoo.org> <1120487242.11399.5.camel@imp.csi.cam.ac.uk>
	 <42C9788F.50205@gentoo.org>
	 <Pine.LNX.4.60.0507042008310.7572@hermes-1.csi.cam.ac.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 04 Jul 2005 21:33:22 -0400
Message-Id: <1120527203.18268.2.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-04 at 20:09 +0100, Anton Altaparmakov wrote:
> On Mon, 4 Jul 2005, Daniel Drake wrote:
> > Anton Altaparmakov wrote:
> > > )-:  I have addressed the only things I can think off that could cause
> > > the oops and below is the resulting patch.  Could you please test it?
> > 
> > Yeah!! After removing I_WILL_FREE stuff, that fixed both the oops *and* the
> > hang. Everything works nicely now.
> 
> Great!  Thanks a lot for testing!  I will send a patch to Robert and 
> Andrew in a minute with more comments added.

Nice work, I am going to have a closer look at the patch soon. Could you
post the final patch at http://bugzilla.kernel.org/show_bug.cgi?id=4796

Thanks,
-- 
John McCutchan <ttb@tentacle.dhs.org>
