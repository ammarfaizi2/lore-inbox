Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292386AbSBYXCZ>; Mon, 25 Feb 2002 18:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292391AbSBYXCQ>; Mon, 25 Feb 2002 18:02:16 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:51979 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S292386AbSBYXCH>; Mon, 25 Feb 2002 18:02:07 -0500
Date: Tue, 26 Feb 2002 00:01:56 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18
Message-ID: <20020225230156.GA11786@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020225200618.0FAE82069E@eos.telenet-ops.be> <Pine.LNX.4.21.0202251631170.31542-100000@freak.distro.conectiva> <20020225.140851.31656207.davem@redhat.com> <3C7AB893.4090800@ellinger.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C7AB893.4090800@ellinger.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2002, Rainer Ellinger wrote:

> David S. Miller wrote:
> 
> >We can avoid this kind of mess in the future if the "-rc*" releases
> >really are "release candidates" instead of "just another diff".
> 
> And how should EXTRAVERSION be accommodated?

sed/perl/awk -- a short five-liner "bless-rc-to-final" script should do.
A fixed procedure to just fix the Makefile, removing the -rc tag, and
copy over the stuff, can prevent that. If it's considered important
enough by the maintainer, of course.
