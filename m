Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWBIP4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWBIP4y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 10:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWBIP4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 10:56:54 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:8832 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S932236AbWBIP4x convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 10:56:53 -0500
To: Diego Calleja <diegocg@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: git for dummies, anyone?
References: <20060208070301.1162e8c3.pj@sgi.com>
	<yq0vevollx4.fsf@jaguar.mkp.net> <43EB4F05.8090400@pobox.com>
	<20060209163546.493334f8.diegocg@gmail.com>
From: Jes Sorensen <jes@sgi.com>
In-Reply-To: <20060209163546.493334f8.diegocg@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Date: 09 Feb 2006 10:56:38 -0500
Message-ID: <yq0d5hwle4p.fsf@jaguar.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=latin-iso8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Diego" == Diego Calleja <diegocg@gmail.com> writes:

Diego> El Thu, 09 Feb 2006 09:17:41 -0500, Jeff Garzik
Diego> <jgarzik@pobox.com> escribiŽó:

>> Check out: http://linux.yyz.us/git-howto.html

Diego> That is a nice guide, but is oriented to developers, I think
Diego> jes was asking from a user POV (I've needed to google for such
Diego> things several times) ie how to switch to a given tag and
Diego> return to master, how to update the repository periodically,
Diego> etc; no stuff about how to manage patches. It may be nice to
Diego> see such thing on your guide, something like this:

Diego,

Yup thats pretty much it. My usage of git upto now has pretty much
been:

quilt pop -a
git-pull
quilt push -a
<rebuild>

Suddenly something broke with the git-pull and I needed to track down
which change it was.

Cheers,
Jes
