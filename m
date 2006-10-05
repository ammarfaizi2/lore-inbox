Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWJEPUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWJEPUL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 11:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWJEPUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 11:20:11 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:54354 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932113AbWJEPUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 11:20:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cLtFHXJwrRkIoUWLIPYC6ngafu9PZF/sc3hr3fOoGe3EJlbtoVZOM0OYMfJWLhCSuetOLad81m6Iq6yKH0cwJLVvTLKsF4aABI+wNkavAoVOFAUbjVnfA3jig3Jr0x+f+qcDrFmuYgLWte1MXRai25eglMx17p8SxFj3TuHOZCw=
Message-ID: <5a4c581d0610050820m11779c4er7a323cfec49cd39a@mail.gmail.com>
Date: Thu, 5 Oct 2006 15:20:06 +0000
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: jt@hpl.hp.com
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "John W. Linville" <linville@tuxdriver.com>,
       "Jeff Garzik" <jeff@garzik.org>, "Lee Revell" <rlrevell@joe-job.com>,
       "Norbert Preining" <preining@logic.at>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net
In-Reply-To: <20061005002637.GA5145@bougret.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061003214038.GE23912@tuxdriver.com>
	 <20061004181032.GA4272@bougret.hpl.hp.com>
	 <Pine.LNX.4.64.0610041133040.3952@g5.osdl.org>
	 <20061004185903.GA4386@bougret.hpl.hp.com>
	 <Pine.LNX.4.64.0610041216510.3952@g5.osdl.org>
	 <20061004195229.GA4459@bougret.hpl.hp.com>
	 <Pine.LNX.4.64.0610041311420.3952@g5.osdl.org>
	 <20061004204718.GA4599@bougret.hpl.hp.com>
	 <Pine.LNX.4.64.0610041522190.3952@g5.osdl.org>
	 <20061005002637.GA5145@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/06, Jean Tourrilhes <jt@hpl.hp.com> wrote:
> On Wed, Oct 04, 2006 at 03:26:09PM -0700, Linus Torvalds wrote:
> >
> > The very fact that this turned into a discussion is a sign that the ABI
> > breakage wasn't handled well enough. Usually, when we do something, nobody
> > ever even notices.
>
>         There was the grand total of *ONE* user who was personally
> impacted by the userspace API change (the two other, one was hit by a
> bug, now fixed, one was hit because of kernel API change + external
> driver). And I immediately proposed to postpone the change to a later
> time.

And said user, being me, is currently running with upgraded userspace
 without any issues (counting upgrading userspace as a non-issue).

I originally logged my report as I do for other things that break or look
 different in new snapshots, in order to provide early feedback to the
 kernel developers - I guess it's the actual point of having snapshots
 from kernel.org...

Thanks, ciao,

--alessandro

"Well a man has two reasons for things that he does
  the first one is pride and the second one is love
  all understandings must come by this way"

     (Husker Du, 'She Floated Away')
