Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265010AbSJVTj3>; Tue, 22 Oct 2002 15:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265018AbSJVTj2>; Tue, 22 Oct 2002 15:39:28 -0400
Received: from barbados.bluemug.com ([63.195.182.101]:61200 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id <S265010AbSJVTjG>; Tue, 22 Oct 2002 15:39:06 -0400
Date: Tue, 22 Oct 2002 12:45:12 -0700
To: Jesse Pollard <pollard@admin.navo.hpc.mil>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 1/4] fix NGROUPS hard limit (resend)
Message-ID: <20021022194512.GA18955@bluemug.com>
Mail-Followup-To: Jesse Pollard <pollard@admin.navo.hpc.mil>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200210220036.g9M0aP831358@scl2.sfbay.sun.com> <1035308740.31873.107.camel@irongate.swansea.linux.org.uk> <3DB58CBD.3030207@sun.com> <200210221303.47488.pollard@admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210221303.47488.pollard@admin.navo.hpc.mil>
X-PGP-Key: http://web.bluemug.com/~miket/OpenPGP/5C09BB33.asc
X-PGP-Fingerprint: C518 67A5 F5C5 C784 A196  B480 5C97 3BBD 5C09 BB33
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 01:03:47PM -0500, Jesse Pollard wrote:
> 
> And I really doubt that anybody has 10000 unique groups (or even
> close to that) running under any system. The center I'm at has
> some of the largest UNIX systems ever made, and there are only
> about 600 unique groups over the entire center. The largest number
> of groups a user can be in is 32. And nobody even comes close.

Large CVS hosting operations like GNU Savannah have historically used
patches to increase NGROUPS.  Using one group per project in CVS is the
sanest way to manage a big repository with complex permissions.

miket
