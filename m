Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbVFPPEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVFPPEX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 11:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVFPPEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 11:04:23 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:16845 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261604AbVFPPEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 11:04:20 -0400
Date: Thu, 16 Jun 2005 11:04:19 -0400
To: "Richard B. Johnson" <linux-os@analogic.com>
Cc: Lukasz Stelmach <stlman@poczta.fm>, mru@inprovide.com,
       Patrick McFarland <pmcfarland@downeast.net>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Message-ID: <20050616150419.GY23488@csclub.uwaterloo.ca>
References: <yw1xslzl8g1q.fsf@ford.inprovide.com> <42AFE624.4020403@poczta.fm> <200506150454.11532.pmcfarland@downeast.net> <42AFF184.2030209@poczta.fm> <yw1xd5qo2bzd.fsf@ford.inprovide.com> <42B04090.7050703@poczta.fm> <20050615212825.GS23621@csclub.uwaterloo.ca> <42B0BAF5.106@poczta.fm> <20050616133904.GU23488@csclub.uwaterloo.ca> <Pine.LNX.4.61.0506161036370.30607@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0506161036370.30607@chaos.analogic.com>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2005 at 10:44:52AM -0400, Richard B. Johnson wrote:
> You know this problem was "solved" over 20 years ago when it was
> discovered that file-names could never be long enough. The solution
> was a container-file which contained as much stuff as necessary to
> identity the contents of the file that it was associated with. Using
> this technique, the "real" file didn't need any ASCII identifiers. The
> real file didn't show up in some directory program, just the contents
> of the container-file. This same technique could be used for any
> arbitrary file-identification including characters that haven't been
> invented yet.

Why am I suddenly reminded of apple's idiotic filesystem forks for
resources and data?  Such a pain when trying to transfer files to other
types of filesystems.  Modifying the files themselves also doesn't seem
like the right solution.

As for filenames never being long enough, I don't think that is true.
Filenames CAN be too long, but I don't see very many people think 250
characters makes for a useful filename.  Most people seem happy with 50
or so being a good limit even though many systems support much longer.
8 wasn't enough, and 25 or 30 was sometimes a bit short, but usually
enough.  Not having enough filename length doesn't seem to be a problem
in need of a solution on most systems anymore.

Len Sorensen
