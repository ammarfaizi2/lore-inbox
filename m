Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267289AbTBDTv2>; Tue, 4 Feb 2003 14:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267436AbTBDTv2>; Tue, 4 Feb 2003 14:51:28 -0500
Received: from unthought.net ([212.97.129.24]:8378 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S267289AbTBDTv1>;
	Tue, 4 Feb 2003 14:51:27 -0500
Date: Tue, 4 Feb 2003 21:01:01 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Scott McDermott <vaxerdec@frontiernet.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS question
Message-ID: <20030204200100.GA15609@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Scott McDermott <vaxerdec@frontiernet.net>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.21.0302041038120.8655-100000@source.intac.net> <20030204145020.A23244@newbox.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030204145020.A23244@newbox.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2003 at 02:50:20PM -0500, Scott McDermott wrote:
> kernellist@source.intac.net on Tue  4/02 10:51 -0500:
> > I have quite a few servers running kernel 2.4.18. I need to replace an
> > nfs server that all my linux clients mount, and I want to know if
> > there is a way for me to do this without having to umount and remount
> > everything.
> 
> I *think* it will work if you keep major, minor, and inode numbers on
> the new server the same for anything clients have mounted.  These are
> used to construct the cookies handed to clients.

If you do not preserve inode numbers, it will for *certain* not work
(speaking of experience  ;)


-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
