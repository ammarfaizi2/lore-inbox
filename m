Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbVI3IOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbVI3IOK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 04:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbVI3IOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 04:14:10 -0400
Received: from xproxy.gmail.com ([66.249.82.204]:4470 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030243AbVI3IOI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 04:14:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WAahp1PGWbmgjkwFPkEGsPsmyoyvE1gpYru4zIe3Aj9PoFQuMjwfrIt/+DsxH4QP0ddjC1lvXyFyKnuPyYGkoSTrbpe7fXLcnjWbFzG0Xy/P1QGiGX5LPMyrysXWnjv2AVfPe2GbZkNAamhTDlQYDtxBBQY7IpLStclO5DahLpQ=
Message-ID: <d93f04c70509300114i1757cde1x42d9fe7c453a8bbd@mail.gmail.com>
Date: Fri, 30 Sep 2005 10:14:07 +0200
From: Hendrik Visage <hvjunk@gmail.com>
Reply-To: Hendrik Visage <hvjunk@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Starfire (Adaptec) kernel 2.6.13+ panics on AMD64 NFS server
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       Ion Badulescu <ionut@badula.org>
In-Reply-To: <20050929211649.69eaddee.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d93f04c70509292036x269df799y7b51c5be9c3356d6@mail.gmail.com>
	 <20050929211649.69eaddee.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/05, Andrew Morton <akpm@osdl.org> wrote:
> A serial console is useful.  Often people will take a digital photo of the
> screen, which works OK.  But we do need that info somehow, please.

busy getting that (and/or lkcd|kdb) setup..

> The starfire changes in 2.6.12->2.6.13 look fairly innocuous.  Need that
> trace, please.

Will do, but check perhaps for some 64bit uncleanes in the scatter gather stuff
that got enabled in 2.6.13 because of the GPL'd Adaptec firmware, as I
recalled some skb related stuff.

--
Hendrik Visage
