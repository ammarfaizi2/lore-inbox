Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266251AbRGJNtt>; Tue, 10 Jul 2001 09:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266181AbRGJNti>; Tue, 10 Jul 2001 09:49:38 -0400
Received: from weta.f00f.org ([203.167.249.89]:38274 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S266251AbRGJNt0>;
	Tue, 10 Jul 2001 09:49:26 -0400
Date: Wed, 11 Jul 2001 01:49:20 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Adam Shand <larry@spack.org>, linux-kernel@vger.kernel.org
Subject: Re: What is the truth about Linux 2.4's RAM limitations?
Message-ID: <20010711014920.D31799@weta.f00f.org>
In-Reply-To: <Pine.LNX.4.32.0107091250170.25061-100000@maus.spack.org> <20010710011755.M18653@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010710011755.M18653@mea-ext.zmailer.org>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2001 at 01:17:55AM +0300, Matti Aarnio wrote:

       Compound that with unability to have separate user and kernel
       mappings active at the same time (unlike e.g. Motorola 68000
       family MMUs do), and the userspace can't have even that 4GB,
       but is limited to at least 3.5/0.5 (user/kernel) split, more
       commonly to 3.0/1.0 split.

How does FreeBSD do this? What about other OSs? Do they map out most
of userland on syscall entry and map it in as required for their
equivalents to copy_to/from_user? (Taking the performance hit in doing
so?)



  --cw

