Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288662AbSBMTDP>; Wed, 13 Feb 2002 14:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288677AbSBMTDF>; Wed, 13 Feb 2002 14:03:05 -0500
Received: from dsl254-018-238.sea1.dsl.speakeasy.net ([216.254.18.238]:33032
	"EHLO tschenk1.home.techdog.org") by vger.kernel.org with ESMTP
	id <S288662AbSBMTC4>; Wed, 13 Feb 2002 14:02:56 -0500
Subject: Re: Quick question on Software RAID support.
From: Thomas Schenk <tschenk@origin.ea.com>
To: Mukund Ingle <inglem@cisco.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4.2.0.58.20020212172729.0195b630@bulkrate.cisco.com>
In-Reply-To: <4.2.0.58.20020212172729.0195b630@bulkrate.cisco.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 13 Feb 2002 12:57:16 -0600
Message-Id: <1013626750.11562.7.camel@bagend.origin.ea.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-02-12 at 19:34, Mukund Ingle wrote:
> 
> 1) Does the Software RAID-5 support automatic detection
>      of a drive failure? How?
> 
> 2) Has Linux Software RAID-5 been used in the Enterprise environment
>      to support redundancy by any real-world networking company
>      or this is just a tool used by individuals to provide redundancy on
>      their own PCs in the labs and at home?

I don't know if this qualifies as "in the Enterprise environment to
support redundancy by any real-world networking company", but when I
worked at Deja.com (aka Dejanews), we used software RAID on production
servers (database hosts mostly) and it worked fine.  The only problems
we ever had with it were due to human error (running fsck on individual
drives in the arrays).

Tom S.
 
-- 
  
+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
   | Tom Schenk            | A positive attitude may not solve all your 
|
   | Online Ops, EA.COM    | problems, but it will annoy enough people
to  |
   | tschenk@origin.ea.com | make it worth the effort. -- Herm Albright 
|
  
+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+

