Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267174AbUBMSvN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 13:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267175AbUBMSvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 13:51:13 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:58584
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S267174AbUBMSvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 13:51:09 -0500
Message-ID: <402D1C68.5030600@redhat.com>
Date: Fri, 13 Feb 2004 10:50:16 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: viro@parcelfarce.linux.theplanet.co.uk,
       Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>,
       Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org
Subject: Re: JFS default behavior
References: <1076604650.31270.20.camel@ulysse.olympe.o2t> <20040213030346.GF25499@mail.shareable.org> <1076695606.23795.23.camel@m222.net81-64-248.noos.fr> <20040213181542.GD8858@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.53.0402131325470.1895@chaos>
In-Reply-To: <Pine.LNX.4.53.0402131325470.1895@chaos>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

> I think that all ASCII characters below 0x20 are forbidden in
> Unix file-names

Not true.  Filenames in Unix are defined as

3.169 Filename
  A name consisting of 1 to {NAME_MAX} bytes used to name a file. The
  characters composing the name may be selected from the set of all
  character values excluding the slash character and the null byte. The
  filenames dot and dot-dot have special meaning. A filename is
  sometimes referred to as a   pathname component  .


Only NUL and / are special.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
