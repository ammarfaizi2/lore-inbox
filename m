Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268170AbTBSJpG>; Wed, 19 Feb 2003 04:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268337AbTBSJpG>; Wed, 19 Feb 2003 04:45:06 -0500
Received: from holomorphy.com ([66.224.33.161]:61592 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268170AbTBSJpF>;
	Wed, 19 Feb 2003 04:45:05 -0500
Date: Wed, 19 Feb 2003 01:54:08 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: Meino Christian Cramer <mccramer@s.netic.de>, efraim@clues.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.62 fails to boot, Uncompressing... and then nothing
Message-ID: <20030219095408.GT29983@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Duncan Sands <baldrick@wanadoo.fr>,
	Meino Christian Cramer <mccramer@s.netic.de>, efraim@clues.de,
	linux-kernel@vger.kernel.org
References: <20030219071932.GA3746@clues.de> <20030219073221.GR29983@holomorphy.com> <20030219.095905.92587466.mccramer@s.netic.de> <200302191052.47663.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302191052.47663.baldrick@wanadoo.fr>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2003 at 10:52:47AM +0100, Duncan Sands wrote:
> This is becoming a FAQ!  Did you enable the console in your .config?
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> Most likely you chose to compile the input system as a module, which
> caused the console options to be autohorribly deselected.  Just say 'y'
> for the input subsystem, at which point the console options will reappear,
> letting you select them.
> I hope this helps,
> Duncan.

If that's really it there's a chuckle or two to be had.


-- wli
