Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317371AbSFGX6J>; Fri, 7 Jun 2002 19:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317372AbSFGX6I>; Fri, 7 Jun 2002 19:58:08 -0400
Received: from holomorphy.com ([66.224.33.161]:13969 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317371AbSFGX6H>;
	Fri, 7 Jun 2002 19:58:07 -0400
Date: Fri, 7 Jun 2002 16:58:00 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org, kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: remove magic numbers for fault return codes
Message-ID: <20020607235800.GB22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org,
	kernel-janitor-discuss@lists.sourceforge.net
In-Reply-To: <20020607235259.GP6777@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2002 at 04:52:59PM -0700, William Lee Irwin III wrote:
> This patch removes them in favor of defining integer constants with
> mnemonic names and using them as the return codes and in dispatches
> on the return values from handle_mm_fault(), and also removing some of
> the associated comments explaining what the magic numbers mean at
> various points where they were formerly used. In addition two redundant
> variables were removed, a comment was added to the bad_wp_page: label
> to explain to onlookers more of what the printk() there means, and
> failure to match the return code with a value in the various switch()
> statements on the return code was flagged as a BUG() at various points.

This is against 2.5.20, sorry for not mentioning that before.


Cheers,
Bill
