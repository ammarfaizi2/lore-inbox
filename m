Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291551AbSBSR7u>; Tue, 19 Feb 2002 12:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291555AbSBSR7l>; Tue, 19 Feb 2002 12:59:41 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:8872 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S291551AbSBSR7Y>;
	Tue, 19 Feb 2002 12:59:24 -0500
Date: Tue, 19 Feb 2002 09:59:28 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: Jens Schmidt <j.schmidt@paradise.net.nz>, linux-kernel@vger.kernel.org
Subject: Re: secure erasure of files?
Message-ID: <31030000.1014141568@flay>
In-Reply-To: <200202191732.SAA08008@cave.bitwizard.nl>
In-Reply-To: <200202191732.SAA08008@cave.bitwizard.nl>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Some success is rumored to be able to be achieved by sampling the
> normal signal, and then subtracting the "expected signal assuming the
> current sequence of bits that was read". That way you might be able to
> recover the information that peeks out from below. 

It's more than rumour - I've seen this done. Dr Solomon's (whatever
they called their data recovery branch), early 1990's, England.
Maybe it was easier on older hardware like the MFM / RLL disks,
and certainly easier to piece together fragmented data with earlier
file formats.

I believe the point of overwriting 3 times (or whatever) is to reduce
the "subtracted difference" to noise levels where it's no longer useful.

> In practise all this doesn't work: The head will not be mispositioned
> 0.1 track to the same side during the whole revolution. Thus you will
> have parts of the previous data generation peeking out on the left
> side for part of the track and data from the generation before on the
> other side. Which you will see is not predetermined.

This only deals with your first method (which I agree, sounds unlikely
to work).

M.

PS. I've also seen a disk arm being wound across an opened disk
platter by a micrometer strapped to the head by a rubber band, 
to recover real data. Most amusing ;-).

