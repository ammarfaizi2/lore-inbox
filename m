Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbTESLdA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 07:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbTESLc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 07:32:59 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:55313 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262407AbTESLc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 07:32:59 -0400
Date: Mon, 19 May 2003 12:45:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       KML <linux-kernel@vger.kernel.org>
Subject: Re: Recent changes to sysctl.h breaks glibc
Message-ID: <20030519124539.B8868@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schlemmer <azarah@gentoo.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	KML <linux-kernel@vger.kernel.org>
References: <1053289316.10127.41.camel@nosferatu.lan> <20030518204956.GB8978@holomorphy.com> <1053292339.10127.45.camel@nosferatu.lan> <20030519063813.A30004@infradead.org> <1053341023.9152.64.camel@workshop.saharact.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1053341023.9152.64.camel@workshop.saharact.lan>; from azarah@gentoo.org on Mon, May 19, 2003 at 12:43:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 12:43:44PM +0200, Martin Schlemmer wrote:
> Ok, lets say we stop doing that.  How do anything user side find
> out specifics at compile time related to the kernel it should run
> on ?

They don't.  You can run the same userspace on a wide range of kernels.
I'd just leave the job of selcting your headers to the distro vendor -
if they are too stupid to get their headers sanitized I'd
just use a different distro.

