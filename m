Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292895AbSBVPU3>; Fri, 22 Feb 2002 10:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292898AbSBVPUT>; Fri, 22 Feb 2002 10:20:19 -0500
Received: from trained-monkey.org ([209.217.122.11]:62727 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP
	id <S292895AbSBVPUN>; Fri, 22 Feb 2002 10:20:13 -0500
From: Jes Sorensen <jes@trained-monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15478.25001.512565.628500@trained-monkey.org>
Date: Fri, 22 Feb 2002 10:20:09 -0500
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Troy Benjegerdes <hozer@drgw.net>,
        wli@holomorphy.com, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bring sanity to div64.h and do_div usage
In-Reply-To: <3C7660F5.FC238A7E@mandrakesoft.com>
In-Reply-To: <5.1.0.14.2.20020208113710.04ecedf0@pop.cus.cam.ac.uk>
	<20020207234555.N17426@altus.drgw.net>
	<5.1.0.14.2.20020208181656.03862ec0@pop.cus.cam.ac.uk>
	<d37kp5v9y5.fsf@lxplus050.cern.ch>
	<3C7660F5.FC238A7E@mandrakesoft.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jeff" == Jeff Garzik <jgarzik@mandrakesoft.com> writes:

Jeff> Jes Sorensen wrote:
>> __mc68000__ is the correct define, I don't know who put in
>> CONFIG_M68K but it doesn't belong there.

Jeff> I disagree -- look at arch/*/config.in.

Jeff> Each arch needs to define a CONFIG_$ARCH.

Why? CONFIG_$ARCH only makes sense if you can enable two architectures
in the same build. What does CONFIG_M68K give you that __mc68000__
doesn't provide?

Jes
