Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268279AbUH2T03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268279AbUH2T03 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 15:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268281AbUH2T03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 15:26:29 -0400
Received: from hera.cwi.nl ([192.16.191.8]:48512 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S268279AbUH2T01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 15:26:27 -0400
Date: Sun, 29 Aug 2004 21:26:17 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: William Lee Irwin III <wli@holomorphy.com>,
       mita akinobu <amgta@yacht.ocn.ne.jp>, linux-kernel@vger.kernel.org,
       Andries Brouwer <Andries.Brouwer@cwi.nl>,
       Alessandro Rubini <rubini@ipvvis.unipv.it>
Subject: Re: [util-linux] readprofile ignores the last element in /proc/profile
Message-ID: <20040829192617.GB24937@apps.cwi.nl>
References: <200408250022.09878.amgta@yacht.ocn.ne.jp> <20040829162252.GG5492@holomorphy.com> <20040829184114.GS5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040829184114.GS5492@holomorphy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2004 at 11:41:14AM -0700, William Lee Irwin III wrote:
> On Sun, Aug 29, 2004 at 09:22:52AM -0700, William Lee Irwin III wrote:
> > Well, since I couldn't stop vomiting for hours after I looked at the
> > code for readprofile(1), here's a reimplementation, with various
> > misfeatures removed, included as a MIME attachment.
> 
> I guess I might as well write a diffprof(1) too.

Thanks!

<mutter>
Is it really necessary to tell Alessandro Rubini, Stephane Eranian,
Andrew Morton, Werner Almesberger, John Levon, Nikita Danilov
that their work makes you vomit?
Many kernel people have such unpleasant habits.
It fully suffices to say that you considered the original code
too ugly to fix.
</mutter>

<util-linux maintainer>
Your code still requires some polishing. No localized messages, etc.
And next, you removed some features, but do not indicate what
replacement you see.
For example, Andrew added the -M option that sets a frequency.
Are you going to contribute a write_profile too?
Or do you think nobody should wish to set a frequency?
</util-linux maintainer>

Andries
