Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268146AbTBSHXW>; Wed, 19 Feb 2003 02:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268147AbTBSHXW>; Wed, 19 Feb 2003 02:23:22 -0500
Received: from holomorphy.com ([66.224.33.161]:29592 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268146AbTBSHXV>;
	Wed, 19 Feb 2003 02:23:21 -0500
Date: Tue, 18 Feb 2003 23:32:21 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Alexander Koch <efraim@clues.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.62 fails to boot, Uncompressing... and then nothing
Message-ID: <20030219073221.GR29983@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alexander Koch <efraim@clues.de>, linux-kernel@vger.kernel.org
References: <20030219071932.GA3746@clues.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030219071932.GA3746@clues.de>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2003 at 08:19:32AM +0100, Alexander Koch wrote:
> I am experiencing problems getting certain 2.5.60 and
> 2.5.61 and also 2.5.62 to boot. One 2.5.60 is working,
> the others are just doing something as I only see the
> Uncompressing... and then nothing is happening at all
> except my hard disc doing something which is not booting,
> I feel. I fail to remember what the difference was between
> the two versions of 2.5.60 (one running, the other is not).
> Any ideas/hints on what this is?

Do you have ACPI in your .config? Various ppl have been having
issues resolved when ACPI's deconfigured lately. Breaking out an
early printk patch of some flavor should probably help get some
boot logs out so you can debug if you care to do so.


-- wli
