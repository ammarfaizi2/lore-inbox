Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264865AbSKEPlV>; Tue, 5 Nov 2002 10:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264866AbSKEPlV>; Tue, 5 Nov 2002 10:41:21 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:16277 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264865AbSKEPlV>; Tue, 5 Nov 2002 10:41:21 -0500
Subject: Re: naive but spectacular ext3 HTREE+Orlov benchmark
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: bert hubert <ahu@ds9a.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tytso@mit.edu
In-Reply-To: <20021105151702.GA5894@outpost.ds9a.nl>
References: <20021105151702.GA5894@outpost.ds9a.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Nov 2002 16:10:04 +0000
Message-Id: <1036512604.4827.93.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-05 at 15:17, bert hubert wrote:
> Congratulations everybody, this is a major result! You can in fact *hear*
> the difference. With the Orlov allocator, seeks are much more higher pitched
> as if they are generally over shorter distances - which they probably are.

How does the Orlov allocator do if you continually randomly use and
reuse the file space for a long period of time - the current allocator
is pretty stable, does Orlov behave the same or degenerate ?

