Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbTDQRee (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 13:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbTDQRed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 13:34:33 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:41906 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP id S261747AbTDQRed
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 13:34:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Eric Altendorf <EricAltendorf@orst.edu>
Reply-To: EricAltendorf@orst.edu
To: Randolph Bentson <bentson@grieg.holmsjoen.com>
Subject: Re: kernel support for non-English user messages
Date: Thu, 17 Apr 2003 11:49:05 -0700
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0304141024250.19302-100000@home.transmeta.com> <200304141645.48020.EricAltendorf@orst.edu> <20030417080754.A32133@grieg.holmsjoen.com>
In-Reply-To: <20030417080754.A32133@grieg.holmsjoen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304171149.08098.EricAltendorf@orst.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 April 2003 08:07, Randolph Bentson wrote:
>
> That's true if documentation serves only to describe _what_ the
> code does.  You've ignored the need to describe _why_ the code
> was written in this way.  For example, documentation can note some
> feature of the hardware which requires special handling, or it can
> describe some emergent property which isn't obvious even if all
> the code is understood.
>
> That's why local comments should explain non-obvious trickery used,
> perhaps the exploitation of a poorly documented side-effect of some
> instruction, and block comments or external documentation should
> help the reader understand why things are done some particular way.
> For instance, if the code implements some specific, well documented
> algorithm, it should reference the algorithm by name.

You're right; this is very true.  I suppose I overlooked that due to 
my background in other kinds of code bases...  In an "ideal" code 
base, written from scratch, you'd probably need very very few 
comments.  If you're interfacing with buggy legacy code or 
problematic hardware, I can see there'd be a much greater need.

Eric
