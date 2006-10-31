Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423700AbWJaRXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423700AbWJaRXn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 12:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423703AbWJaRXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 12:23:43 -0500
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:37049 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1423700AbWJaRXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 12:23:42 -0500
Date: Tue, 31 Oct 2006 18:23:10 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Olivier Galibert <galibert@pobox.com>,
       "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Re: Cooling the cache
Message-ID: <20061031172310.GA30739@wohnheim.fh-wedel.de>
References: <20061031171204.GA8230@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061031171204.GA8230@dspnet.fr.eu.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 October 2006 18:12:04 +0100, Olivier Galibert wrote:
> 
> In order to measure reliably some worst-case latencies, is there a way
> to have the system (cleanly) drop as much as possible of its
> page/directory cache?  Being able to specify which device would be a
> plus ;-)

grep -A5 drop_caches Documentation/filesystems/proc.txt

Jörn

-- 
Joern's library part 9:
http://www.scl.ameslab.gov/Publications/Gus/TwelveWays.html
