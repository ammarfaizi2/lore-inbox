Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbUBKACj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 19:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbUBKACj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 19:02:39 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:64659 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S262353AbUBKACh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 19:02:37 -0500
Date: Tue, 10 Feb 2004 16:02:24 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org,
       Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: UTF-8 in file systems? xfs/extfs/etc.
Message-ID: <20040211000224.GJ18674@srv-lnx2600.matchmail.com>
Mail-Followup-To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org,
	Matthias Urlichs <smurf@smurf.noris.de>
References: <20040209115852.GB877@schottelius.org> <pan.2004.02.09.13.36.23.911729@smurf.noris.de> <20040210043212.GF18674@srv-lnx2600.matchmail.com> <20040210230452.GA15892@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210230452.GA15892@pegasys.ws>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 03:04:52PM -0800, jw schultz wrote:
> On Mon, Feb 09, 2004 at 08:32:12PM -0800, Mike Fedyk wrote:
> > On Mon, Feb 09, 2004 at 02:36:24PM +0100, Matthias Urlichs wrote:
> > > Hi, Nico Schottelius wrote:
> > > 
> > > > What Linux supported filesystems support UTF-8 filenames?
> > > 
> > > Filenames, to the kernel, are a sequence of 8-bit things commonly
> > > called "bytes" or "octets", excluding '/' and '\0'.
> > > 
> > 
> > You can have "/" in the filename also, though that could be encoded somehow...
> 
> You might be able to have a non-ASCII character that looks
> like / but not 0x2f.
> 
> I for one do not want open("/var/tpm/diddle", O_WRONLY | O_CREAT)
> to create a file "tpm/diddle" in /var just because /var/tpm
> doesn't exist.  Fortunately what happens is it fails with
> ENOENT.

OK, I stand corrected.

Thanks.
