Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132910AbQLOAGF>; Thu, 14 Dec 2000 19:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131370AbQLOAFz>; Thu, 14 Dec 2000 19:05:55 -0500
Received: from otitsun.oulu.fi ([130.231.48.144]:16626 "EHLO otitsun.oulu.fi")
	by vger.kernel.org with ESMTP id <S132910AbQLOAFj>;
	Thu, 14 Dec 2000 19:05:39 -0500
Date: Fri, 15 Dec 2000 01:34:56 +0200
From: Tuomas Haarala <tuoppi@otitsun.oulu.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: NFS v2 attribute problem with 2.2.18?
Message-ID: <20001215013456.A25278@otitsun.oulu.fi>
In-Reply-To: <200012121103.MAA01248@isis.helios.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200012121103.MAA01248@isis.helios.de>; from jum@helios.de on Tue, Dec 12, 2000 at 12:03:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2000 at 12:03:35PM +0100, Jens-Uwe Mager wrote:
> ramses$ /bin/mkdir yyy; /bin/touch yyy/xxx 
> /bin/touch: yyy/xxx: Permission denied

	I've had similar problems with previous kernels, altough not at
	the same situation.

	If I try to touch a file which is on NFS mounted directory,
	I get "Permission denied" despite group I belong to has full
	access to this file. I can edit and remove the file with no
	problems, but touch doesn't work.

	This is rather tricky situation, as compiling code gets quite
	difficult for this group, as only the owned can touch the file
	despite the effective permissions on file (and previous directories).

-Tuoppi-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
