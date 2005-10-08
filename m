Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbVJHQji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbVJHQji (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 12:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbVJHQji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 12:39:38 -0400
Received: from host62-24-231-115.dsl.vispa.com ([62.24.231.115]:10476 "EHLO
	orac.walrond.org") by vger.kernel.org with ESMTP id S932133AbVJHQjh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 12:39:37 -0400
From: Andrew Walrond <andrew@walrond.org>
To: "John Stoffel" <john@stoffel.org>
Subject: Re: Anybody know about nforce4 SATA II hot swapping + linux raid?
Date: Sat, 8 Oct 2005 17:39:35 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, Molle Bestefich <molle.bestefich@gmail.com>,
       htejun@gmail.com, linux-raid@vger.kernel.org
References: <200510071111.46788.andrew@walrond.org> <200510081555.41159.andrew@walrond.org> <17223.61190.917668.850611@smtp.charter.net>
In-Reply-To: <17223.61190.917668.850611@smtp.charter.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510081739.35566.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 October 2005 17:08, John Stoffel wrote:
>
> Hmm... I've been watching those 3ware discussions with interest as
> well, but I haven't seen any commments on how well they work as JBOD
> controllers, esp if you get smaller ones with fewer channels and
> stripe/mirror between controllers.  If you pair disks between
> controllers, then that should limit the downtime, and also improve
> performance.

My application has hundreds/thousands of threads doing simultaneous small 
reads, with infrequent small writes. Any problems would probably be mitigated 
by having loads of ram for linux to use as disk cache, but this does seem to 
be an access model at which the 3ware hardware is not good at handling. Of 
course, it never hurts to remind them in a public forum; nothing focuses the 
corporate mind better than bad press ;)

Andrew Walrond
