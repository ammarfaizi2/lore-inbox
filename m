Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267083AbUBRB00 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 20:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267094AbUBRB00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 20:26:26 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:3504 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S267083AbUBRB0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 20:26:25 -0500
Message-ID: <4032BF78.70802@namesys.com>
Date: Tue, 17 Feb 2004 17:27:20 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stefan Smietanowski <stesmi@stesmi.com>
CC: Linus Torvalds <torvalds@osdl.org>, Marc Lehmann <pcg@schmorp.de>,
       Jamie Lokier <jamie@shareable.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
References: <200402150107.26277.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216183616.GA16491@schmorp.de> <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <20040216200321.GB17015@schmorp.de> <Pine.LNX.4.58.0402161205120.30742@home.osdl.org> <20040216222618.GF18853@mail.shareable.org> <Pine.LNX.4.58.0402161431260.30742@home.osdl.org> <20040217071448.GA8846@schmorp.de> <Pine.LNX.4.58.0402170739580.2154@home.osdl.org> <20040217161111.GE8231@schmorp.de> <Pine.LNX.4.58.0402170820070.2154@home.osdl.org> <40324741.4040707@stesmi.com>
In-Reply-To: <40324741.4040707@stesmi.com>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ReiserFS 6 plans to allow files to be associated with arbitrary files 
and found by those associations.  Some of those files will consist of 
ascii keywords, some will be icon images, etc.....  Human readability 
should not be considered fundamental to a name component, especially 
since programs with no interest in readability may be the only direct 
users of the name.

Hans


>

