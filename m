Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261585AbSJALsv>; Tue, 1 Oct 2002 07:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261588AbSJALsv>; Tue, 1 Oct 2002 07:48:51 -0400
Received: from k100-28.bas1.dbn.dublin.eircom.net ([159.134.100.28]:44303 "EHLO
	corvil.com.") by vger.kernel.org with ESMTP id <S261585AbSJALsu>;
	Tue, 1 Oct 2002 07:48:50 -0400
Message-ID: <3D998C95.9060606@corvil.com>
Date: Tue, 01 Oct 2002 12:52:53 +0100
From: Padraig Brady <padraig.brady@corvil.com>
Organization: Corvil Networks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: garrett@tbaytel.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE, TRIVIAL, RFC] Linux source strip/bundle script
References: <200210010734.14949.garrett@tbaytel.net>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Garrett Kajmowicz wrote:
> As per the suggestion of the lkml FAQ section 7-7, I have spent some time 
> working on a script to automatically go through the Linux source tree and 
> generate a stripped down version of the kernel source code (x86 only), along 
> with a few additional 'modules' which will contain additional funtionality, 
> if desired (such as irda or scsi support).
> 
> I have requested an account on kernel.org, and hope to run/test this script 
> for each full, stable release.  I would like all of the input possible on the 
> script.  Please note that this is the first version, so there are probably 
> many rough areas.
> 
> For a copy of the script please try:
> 
> http://garrett.dyndns.biz/makemini.sh.bz2
> 
> Please Cc: all comments to:
> 
> Garrett Kajmowicz
> gkajmowi@tbaytel.net

1. There is a distinct dearth (hmm an anagram of redhat) of loops.
2. When trashing the source like this you may as well remove
    trailing whitespace (reduces kernel by 200K after compression).
3. What's the difference in size between 2.4.19.tar.bz2 and
    2.4.19-bastardized.tar.bz2 ?
4. Is this just for (a) removing redundant code after installation or
    (b) providing subset version(s) for download.
5. If 4(a) wouldn't you need to parse the .config to find the appropriate
    bits to remove?

Pádraig.

