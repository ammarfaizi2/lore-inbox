Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261665AbSJCPVO>; Thu, 3 Oct 2002 11:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261667AbSJCPVN>; Thu, 3 Oct 2002 11:21:13 -0400
Received: from mg02.austin.ibm.com ([192.35.232.12]:25277 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261665AbSJCPU7>; Thu, 3 Oct 2002 11:20:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: EVMS Submission for 2.5
Date: Thu, 3 Oct 2002 09:53:49 -0500
X-Mailer: KMail [version 1.2]
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
References: <Pine.GSO.4.21.0210031042210.15787-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0210031042210.15787-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Message-Id: <02100309534906.05904@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 October 2002 09:51, Alexander Viro wrote:
> On Thu, 3 Oct 2002, Kevin Corry wrote:
> > > IOW, the real question is what are you going to do with that list of
> > > gendisks?
> >
> > EVMS will try to read volume metadata from each device and activate
> > volumes if it finds any pertinent metadata.
>
> _Ouch_.  "Each" as in...?  E.g. do you want to do that for floppies? 
> Cdroms? EVMS volumes themselves?  Things like /dev/loop? (and if yes, at
> which point do you do that?)

EVMS can filter out devices that don't make sense to probe for volumes. 
Currently it ignores such things as floppies and cd-roms, as well as EVMS 
volumes. We have actually added the ability to probe loop devices, though, 
since we had several requests for that functionality.

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/
