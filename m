Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262941AbVG3Fyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbVG3Fyp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 01:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262944AbVG3Fyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 01:54:45 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:41914 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262941AbVG3Fyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 01:54:44 -0400
Date: Fri, 29 Jul 2005 22:54:32 -0700
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] String conversions for memory policy
Message-Id: <20050729225432.63b3dfb0.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.62.0507291746000.8663@graphe.net>
References: <Pine.LNX.4.62.0507291137240.3864@graphe.net>
	<20050729152049.4b172d78.pj@sgi.com>
	<Pine.LNX.4.62.0507291746000.8663@graphe.net>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph wrote:
> you could have a look at my initial patch which actually
> included a description of the syntax 

Yes - I could (I did actually).

Something like that should be part of the record here.  Not everyone
has your earlier linux-mm email thread right at hand.


> Diff to use bitmap_scnlistprintf and bitmap_parselist.

That was quick - thanks.

Once we have a clear description of this syntax in the record,
I anticipate raising as an issue that this syntax does not have a
single integer or string token value per file (or at most, an array
or list of comparable integer values).

But first things first.  Until any lurkers can easily see what is being
proposed, it is inconvenient to carry on discussions of alternatives
and their relative merits.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
