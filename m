Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131580AbRCNXls>; Wed, 14 Mar 2001 18:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131569AbRCNXlj>; Wed, 14 Mar 2001 18:41:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26131 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S131580AbRCNXl1>;
	Wed, 14 Mar 2001 18:41:27 -0500
Date: Wed, 14 Mar 2001 23:39:58 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Andries.Brouwer@cwi.nl
Cc: rhw@MemAlpha.CX, kaboom@gatech.edu, linux-kernel@vger.kernel.org,
        seberino@spawar.navy.mil
Subject: Re: [PATCH] Improved version reporting
Message-ID: <20010314233958.A6124@flint.arm.linux.org.uk>
In-Reply-To: <UTC200103141929.UAA178418.aeb@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <UTC200103141929.UAA178418.aeb@vlet.cwi.nl>; from Andries.Brouwer@cwi.nl on Wed, Mar 14, 2001 at 08:29:53PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2001 at 08:29:53PM +0100, Andries.Brouwer@cwi.nl wrote:
> There is no other source. Some people like to repack but that
> has no influence on versions.

I believe that RedHat don't build mount and util-linux from the same tree.
Maybe they do internally, but when you look at the RPMs, they appear
separate:

Name: mount
Source RPM: mount-2.10m-6.src.rpm

Name: util-linux
Source RPM: util-linux-2.10m-12.src.rpm

There don't appear to be any explicit dependencies between these two
packages either, but they do just happen to have the same version.
(I'm looking at the RH7.0 RPMs here).

This of course means that the version of mount may not match the version
of util-linux installed on the system.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

