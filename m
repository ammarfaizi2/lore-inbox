Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312134AbSDEDAv>; Thu, 4 Apr 2002 22:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312169AbSDEDAl>; Thu, 4 Apr 2002 22:00:41 -0500
Received: from to-velocet.redhat.com ([216.138.202.10]:5879 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S312134AbSDEDAW>; Thu, 4 Apr 2002 22:00:22 -0500
Date: Thu, 4 Apr 2002 22:00:22 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>, joeja@mindspring.com,
        linux-kernel@vger.kernel.org
Subject: Re: faster boots?
Message-ID: <20020404220022.F24914@redhat.com>
In-Reply-To: <3CACEF18.CE742314@zip.com.au> <200204050218.g352ILY32221@vindaloo.ras.ucalgary.ca> <3CAD1142.82527917@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2002 at 06:51:46PM -0800, Andrew Morton wrote:
> Still.  Joe tells me (offlist) that his machine is taking
> ages just to get to the "starting init" stage.

I find that on heavily scsi systems: one machine spins each of 13 disks 
up sequentially.  This makes the initial boot take 3-5 minutes before 
init even gets its foot in the door.  If someone made a patch to spin 
up scsi disks on the first access, I'd gladly give it a test. ;-)

		-ben
-- 
"A man with a bass just walked in,
 and he's putting it down
 on the floor."
