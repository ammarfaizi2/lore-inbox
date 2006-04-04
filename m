Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWDDQab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWDDQab (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 12:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWDDQ36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 12:29:58 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3086 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750745AbWDDQ34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 12:29:56 -0400
Date: Tue, 4 Apr 2006 18:29:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, len.brown@intel.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: 2.6.17-rc1-mm1: why did acpi_ns_build_external_path() become global?
Message-ID: <20060404162955.GN6529@stusta.de>
References: <20060404014504.564bf45a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060404014504.564bf45a.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 01:45:04AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.16-mm2:
> 
>  git-acpi.patch
>...
>  git trees.
>...

acpi_ns_build_external_path() became global but isn't used outside the 
file it's defined in.

Was this accidental or is a usage pending?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

