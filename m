Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266520AbSKZSp6>; Tue, 26 Nov 2002 13:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266527AbSKZSp5>; Tue, 26 Nov 2002 13:45:57 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:33034 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S266520AbSKZSp5>;
	Tue, 26 Nov 2002 13:45:57 -0500
Date: Tue, 26 Nov 2002 19:53:12 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: ebuddington@wesleyan.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.49: "hdb: cannot handle device with more than 16 heads"
Message-ID: <20021126185312.GA5060@win.tue.nl>
References: <20021126125019.A81@ma-northadams1b-112.nad.adelphia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021126125019.A81@ma-northadams1b-112.nad.adelphia.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2002 at 12:50:19PM -0500, Eric Buddington wrote:

> This is 2.5.49, compiled for i386 with almost all modules using
> gcc-3.2.  On my PII Omnibook 4100, the messages stop after the first
> hda: message (where it would normally identify the drive). The same
> problem existed in 2.4.48.
> 
> When booting on my Athlon (hda:Maxtor 5T040H4, hdb: Maxtor 90840D6), I
> get the following boot messages:
> 
> hda: cannot handle device with more than 16 heads - giving up

You don't want to use the new ide driver instead of the legacy hd one?

Andries
