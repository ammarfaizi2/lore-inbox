Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265736AbUBJHlv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 02:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265742AbUBJHlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 02:41:50 -0500
Received: from disk.smurf.noris.de ([192.109.102.53]:63971 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S265736AbUBJHls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 02:41:48 -0500
From: "Matthias Urlichs" <smurf@smurf.noris.de>
Date: Tue, 10 Feb 2004 05:53:16 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: UTF-8 in file systems? xfs/extfs/etc.
Message-ID: <20040210045315.GA20373@kiste>
References: <20040209115852.GB877@schottelius.org> <pan.2004.02.09.13.36.23.911729@smurf.noris.de> <20040210043212.GF18674@srv-lnx2600.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040210043212.GF18674@srv-lnx2600.matchmail.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Mike Fedyk:
> 
> You can have "/" in the filename also, though that could be encoded somehow...

Such encoding isn't valid UTF-8.

Of course you could use ⁄ instead (fractional slash, U+2044).
Or perhaps ∕ (division slash, U+2215).

How to visually distinguish these from a / (U+002F) is left as an
exercise to the reader.  :-/


The fun part about this email is that I'm writing it with plain old vi
(ummm.... I _do_ know that there's nothing "plain old" about vim ;-)
and I don't see silly square boxes here.

-- 
Matthias Urlichs
