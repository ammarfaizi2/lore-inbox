Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262557AbVCJAkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262557AbVCJAkF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 19:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262401AbVCJAiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 19:38:00 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:40715 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S262572AbVCJAac
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:30:32 -0500
To: linux-kernel@vger.kernel.org
Cc: misc@list.smarden.org, supervision@list.skarnet.org, mkettler@evi-inc.com
Subject: Re: a problem with linux 2.6.11 and sa
References: <20050303214023.GD1251@ixeon.local>
	<6.2.1.2.0.20050303165334.038f32a0@192.168.50.2>
	<20050303224616.GA1428@ixeon.local>
	<871xaqb6o0.fsf@amaterasu.srvr.nix>
	<20050308165814.GA1936@ixeon.local>
	<871xap9dfg.fsf@amaterasu.srvr.nix>
	<20050309152958.GB4042@ixeon.local> <m3is40z9dy.fsf@multivac.cwru.edu>
From: Nix <nix@esperi.org.uk>
X-Emacs: don't cry -- it won't help.
Date: Thu, 10 Mar 2005 00:30:22 +0000
In-Reply-To: <m3is40z9dy.fsf@multivac.cwru.edu> (Paul Jarc's message of
 "Wed, 09 Mar 2005 18:28:35 -0500")
Message-ID: <8765004a1t.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Mar 2005, Paul Jarc uttered the following:
> "George Georgalis" <george@galis.org> wrote:
>> It (Gerrit Pape's technique) very defiantly stopped working a few revs
>> back (2.6.7?). I'm seeing a similar failed read from /dev/rtc and
>> mplayer with 2.6.10, now too.
> 
> The /proc/kmsg problem happens because the kernel now checks for
> permission at read() instead of open().

Am I the only person who thinks `eee-ick, how utterly non-POSIX' at
that?

-- 
> ...Hires Root Beer...
What we need these days is a stable, fast, anti-aliased root beer
with dynamic shading. Not that you can let just anybody have root.
 --- John M. Ford
