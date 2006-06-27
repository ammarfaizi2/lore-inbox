Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030747AbWF0ILX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030747AbWF0ILX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 04:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030749AbWF0ILW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 04:11:22 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:58636 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1030747AbWF0ILW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 04:11:22 -0400
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, kai@germaschewski.name,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Fix 100% initramfs bloat in 2.6.17 versus 2.6.16
References: <87psh3mnay.fsf@hades.wkstn.nix> <87mzbzhk9y.fsf@hades.wkstn.nix>
	<20060626200107.GA777@mars.ravnborg.org>
From: Nix <nix@esperi.org.uk>
X-Emacs: Our Lady of Perpetual Garbage Collection
Date: Tue, 27 Jun 2006 09:11:13 +0100
In-Reply-To: <20060626200107.GA777@mars.ravnborg.org> (Sam Ravnborg's message of "26 Jun 2006 21:02:16 +0100")
Message-ID: <87ac7zggri.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Jun 2006, Sam Ravnborg moaned:
> On Mon, Jun 26, 2006 at 06:57:45PM +0100, Nix wrote:
>> On 21 Jun 2006, nix@esperi.org.uk stipulated:
>> > It didn't take long to work out that this was because my initramfs's
>> > contents were being included twice in the cpio image.
>> 
>> Ping? Anyone?
> It is included in kbuild.git - and Linus has been asked to pull that
> tree. It is also forwarded to stable@kernel.org for inclusion in next
> stable release.

Ah. I checked hpa's git tree and the upstream, but for some reason
not kbuild.git.

Sorry for the noise.

-- 
`NB: Anyone suggesting that we should say "Tibibytes" instead of
 Terabytes there will be hunted down and brutally slain.
 That is all.' --- Matthew Wilcox
