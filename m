Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263354AbTFTQmY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 12:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbTFTQmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 12:42:24 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:63938
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S263354AbTFTQmV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 12:42:21 -0400
Date: Fri, 20 Jun 2003 12:56:20 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Eli Carter <eli.carter@inet.com>
Cc: John Bradford <john@grabjohn.com>, nuno.silva@vgertech.com,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org, samphan@thai.com,
       vojtech@suse.cz
Subject: Re: Crusoe's persistent translation on linux?
Message-ID: <20030620165620.GA9164@gtf.org>
References: <200306201040.h5KAerPK000431@81-2-122-30.bradfords.org.uk> <3EF33B12.7070901@inet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EF33B12.7070901@inet.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 11:49:22AM -0500, Eli Carter wrote:
> Hmm... basically you want to trim the x86 instruction set to get closer 
> to RISC mentality.  Interesting.  gcc may already do that to some extent 
> by not using the really complex instructions.  If that is the case, 
> dropping those instructions might give some room for testing some of its 
> possible benefits.  I doubt restricting the registers used by some 
> instructions would help... I've heard comments that the x86 is 
> register-starved enough already.

Newer CPUs do register renaming in an attempt to avoid the
register-starved ISA issue.  I presume Xmeta would do something
similar...

	Jeff




