Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132337AbRDFTdw>; Fri, 6 Apr 2001 15:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132338AbRDFTdl>; Fri, 6 Apr 2001 15:33:41 -0400
Received: from pizda.ninka.net ([216.101.162.242]:49547 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132337AbRDFTdc>;
	Fri, 6 Apr 2001 15:33:32 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15054.6628.586321.418925@pizda.ninka.net>
Date: Fri, 6 Apr 2001 12:32:52 -0700 (PDT)
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Dawson Engler <engler@csl.Stanford.EDU>, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] __init functions called by non-__init 
In-Reply-To: <m14lbxT-001PHvC@mozart>
In-Reply-To: <200104050649.XAA22384@csl.Stanford.EDU>
	<m14lbxT-001PHvC@mozart>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rusty Russell writes:
 > It's incredibly poor taste, though, and if we ever implement __init
 > dropping for modules (Keith?),

Jakub Jelinek implemented this about 2 years ago, right before
we hit 2.2.x, Linus thought it was too late at the time so
we dropped that work from our trees.

It was really good at finding __init bugs though...

Later,
David S. Miller
davem@redhat.com
