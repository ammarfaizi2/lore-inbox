Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289739AbSAJWhA>; Thu, 10 Jan 2002 17:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289746AbSAJWgt>; Thu, 10 Jan 2002 17:36:49 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:57841 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S289739AbSAJWgr>;
	Thu, 10 Jan 2002 17:36:47 -0500
Date: Thu, 10 Jan 2002 15:36:39 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Where's all my memory going?
Message-ID: <20020110153639.H26688@lynx.adilger.int>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E16OMpF-0001pj-00@the-village.bc.nu> <Pine.LNX.4.33L.0201092034590.2985-100000@imladris.surriel.com> <20020110024520.A29045@em.ca> <20020110030537.C771@lynx.adilger.int> <20020110145542.B2499@mould.bodgit-n-scarper.com> <20020110134657.A26688@lynx.adilger.int> <20020110162445.A13236@em.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020110162445.A13236@em.ca>; from bruceg@em.ca on Thu, Jan 10, 2002 at 04:24:45PM -0600
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 10, 2002  16:24 -0600, Bruce Guenter wrote:
> On Thu, Jan 10, 2002 at 01:46:57PM -0700, Andreas Dilger wrote:
> > One question - what happens to the emails after they are delivered?  Are
> > they kept on the local filesystem?
> 
> Messages in the queue are deleted after delivery (of course).  Messages
> delivered locally are stored on the local filesystem until they're
> picked up by POP (typically within 15 minutes).

Sorry, I meant for the "Postal" benchmark only.  I would hope that locally
delivered emails are kept until the recipient gets it in the normal case.

In any case, you also pointed out the same thing I did, namely that these
slab entries (while having some high numbers) do not account for the large
amount of used memory in the system.  Maybe SysRQ-M output can help a bit?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

