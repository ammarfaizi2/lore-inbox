Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131778AbRC1IHx>; Wed, 28 Mar 2001 03:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131777AbRC1IHo>; Wed, 28 Mar 2001 03:07:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1030 "EHLO www.linux.org.uk") by vger.kernel.org with ESMTP id <S131756AbRC1IHb>; Wed, 28 Mar 2001 03:07:31 -0500
Date: Wed, 28 Mar 2001 09:06:38 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: LA Walsh <law@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: 64-bit block sizes on 32-bit systems
Message-ID: <20010328090638.G7738@parcelfarce.linux.theplanet.co.uk>
References: <3ABF70B9.573C2F85@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ABF70B9.573C2F85@sgi.com>; from law@sgi.com on Mon, Mar 26, 2001 at 08:39:21AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2001 at 08:39:21AM -0800, LA Walsh wrote:
> So...is it the plan, or has it been though about -- 'abstracting'
> block numbes as a typedef 'block_nr', then at compile time
> having it be selectable as to whether or not this was to
> be a 32-bit or 64 bit quantity -- that way older systems would

Oh, did no-one mention the words `Module ABI' yet?

-- 
Revolutions do not require corporate support.
