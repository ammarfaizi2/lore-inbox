Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130826AbRBGBLm>; Tue, 6 Feb 2001 20:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130970AbRBGBLc>; Tue, 6 Feb 2001 20:11:32 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:5650 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130826AbRBGBLR>; Tue, 6 Feb 2001 20:11:17 -0500
Date: Tue, 6 Feb 2001 19:06:24 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: PCI-SCI Drivers v1.1-7 released
Message-ID: <20010206190624.C23960@vger.timpanogas.org>
In-Reply-To: <20010206182501.A23454@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010206182501.A23454@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Tue, Feb 06, 2001 at 06:25:01PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2001 at 06:25:01PM -0700, Jeff V. Merkey wrote:
> 
> Also, the GCC 2.96 compiler shipped with RedHat 7.1 is terribly 
> broken, and does not support #ident lines in the source code, 
> which also means that RedHat 7.1 will not work properly with 
> CVS (Code Versioning System) projects that use the #ident 
> keyword to identify and comment files.  It generates 
> an "unknown keyword" error message.  This version of the 
> sources disables some CVS enablement in order to build properly 
> on a RedHat 7.1 system with gcc 2.96.


More to add on the gcc 2.96 problems.  After compiling a Linux 2.4.1 
kernel on gcc 2.91, running SCI benchmarks, then compiling on RedHat 
7.1 (Fischer) with gcc 2.96, the 2.96 build DROPPED 30% in throughput
from the gcc 2.91 compiled version on the identical SAME 2.4.1 
source tree. 

I think RedHat should jetison gcc 2.96 as soon as possible...

Tests run on a PIII system limited to 90 MB/S PCI throughput.

gcc 2.91 on a PIII system in sci_copy mode           85 MB/S
gcc 2.96 in RedHat 7.1 (Fischer) in sci_copy mode    63 MB/S

Jeff


> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
