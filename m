Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129340AbQK3Mi3>; Thu, 30 Nov 2000 07:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129543AbQK3MiJ>; Thu, 30 Nov 2000 07:38:09 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:15374 "EHLO
        wire.cadcamlab.org") by vger.kernel.org with ESMTP
        id <S129340AbQK3MiF>; Thu, 30 Nov 2000 07:38:05 -0500
Date: Thu, 30 Nov 2000 06:07:32 -0600
To: Android <android@turbosport.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Questions about Kernel 2.4.0.*
Message-ID: <20001130060732.A14250@wire.cadcamlab.org>
In-Reply-To: <001c01c05a86$45bb6380$19211518@vnnys1.ca.home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <001c01c05a86$45bb6380$19211518@vnnys1.ca.home.com>; from android@turbosport.com on Wed, Nov 29, 2000 at 08:30:25PM -0800
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Android]
> 1) There is a link in /lib/modules/2.4.0.11: build->/usr/src/linuxcreated by the Makefile (make modules_install). What for?

Many people limit their e-mail messages to 80 columns.  What for?

The 'build' symlink is to make it easier for external module
installation scripts to find the build directory for a given kernel.
This build directory, in turn, will yield the correct header files,
correct .config, correct compiler flags, etc., all of which can be
important for building a working module.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
