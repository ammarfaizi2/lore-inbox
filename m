Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbTIKU4e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 16:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbTIKU4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 16:56:34 -0400
Received: from dsl092-073-159.bos1.dsl.speakeasy.net ([66.92.73.159]:34828
	"EHLO yupa.krose.org") by vger.kernel.org with ESMTP
	id S261552AbTIKU4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 16:56:33 -0400
To: Andreas Dilger <adilger@clusterfs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Large-file corruption. ReiserFS? VFS?
References: <87r82noyr9.fsf@nausicaa.krose.org>
	<20030911144732.S18851@schatzie.adilger.int>
X-Home-Page: http://www.krose.org/~krose/
From: Kyle Rose <krose+linux-kernel@krose.org>
Organization: krose.org
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 11 Sep 2003 16:56:27 -0400
In-Reply-To: <20030911144732.S18851@schatzie.adilger.int> (Andreas Dilger's
 message of "Thu, 11 Sep 2003 14:47:32 -0600")
Message-ID: <87n0dboxhg.fsf@nausicaa.krose.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) XEmacs/21.4 (Rational FORTRAN,
 i386-debian-linux)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I would guess that mkisofs isn't opening the file with O_LARGEFILE.
> It probably only expected to write 600MB output files.  Purely a
> guess though.

Thanks for the suggestion, but it is, in fact, opening with
O_LARGEFILE:

open("/mnt/angband/krose/tmp/862839.img", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = 3

Cheers,
Kyle
