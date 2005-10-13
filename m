Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751579AbVJMPNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbVJMPNl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 11:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbVJMPNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 11:13:41 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:35045 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1751224AbVJMPNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 11:13:41 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Subject: Re: Linux NTFS Vista compatibility (was: Re: [2.6-GIT] NTFS: Release 2.1.24.)
Date: Thu, 13 Oct 2005 16:13:43 +0100
User-Agent: KMail/1.8.91
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
References: <Pine.LNX.4.21.0509252047090.21817-100000@mlf.linux.rulez.org> <200509252335.37780.s0348365@sms.ed.ac.uk>
In-Reply-To: <200509252335.37780.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510131613.43578.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 25 September 2005 23:35, Alistair John Strachan wrote:
[snip]
> >
> > Alistair, any result?
> >
> > > Note you will need to try the ntfs driver itself and not ntfscp as
> > > libntfs does not have these changes yet hence ntfscp will not work just
> > > the same (it does not use the kernel driver at all, it only uses
> > > libntfs).
> >
> > The latest ntfsprogs CVS has also these changes and every tool should
> > work fine with Vista (ntfscp, ntfsresize, ntfsundelete, ntfsclone, etc).
>
> I have limited access to the beta, as it expires every 30 days and forces
> me to reinstall it. I promise to get back to all of you after 2.6.14 is
> released with the LogFile changes.
>
> To clarify, I did not leave the Vista NTFS volume in an inconsistent state.
> I even forced a chkdsk, rebooted, let it run through, then attempted again
> to mount it with the NTFS code in 2.6.13. This categorically fails.

I was free today, so I built a 2.6.14-rc4 kernel on the machine with the 
Longhorn NTFS volume. It now mounts without warnings in dmesg, and I've 
verified that ntfscp works properly.

Thanks!

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
