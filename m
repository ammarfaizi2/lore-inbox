Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbUL1By3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbUL1By3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 20:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbUL1By2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 20:54:28 -0500
Received: from ms-smtp-03-smtplb.tampabay.rr.com ([65.32.5.133]:34228 "EHLO
	ms-smtp-03.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S262013AbUL1By0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 20:54:26 -0500
Message-ID: <41D0BCCE.4040507@lammerts.org>
Date: Mon, 27 Dec 2004 20:54:22 -0500
From: Eric Lammerts <eric@lammerts.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Unterkircher <unki@netshadow.at>
CC: linux-kernel@vger.kernel.org, Trent Lloyd <lathiat@bur.st>,
       William Park <opengeometry@yahoo.ca>
Subject: Re: waiting 10s before mounting root filesystem?
References: <20041227195645.GA2282@node1.opengeometry.net> <20041227201015.GB18911@sweep.bur.st> <41D07D56.7020702@netshadow.at>
In-Reply-To: <41D07D56.7020702@netshadow.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Unterkircher wrote:
> Or you could try a patch from Randy Dunlap & Eric Lammerts [1] which 
> loops around in do_mounts.c
> until the root filesystem can be mounted.... not that beautiful - but it 
> works :)

> PS: In the same manner you can do it with 2.6

There's a patch for 2.6 (slightly nicer, with a wait queue), see
http://marc.theaimsgroup.com/?l=linux-kernel&m=109122295308836&w=2

Eric
