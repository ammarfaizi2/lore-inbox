Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289099AbSBZXju>; Tue, 26 Feb 2002 18:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289239AbSBZXjc>; Tue, 26 Feb 2002 18:39:32 -0500
Received: from ns.suse.de ([213.95.15.193]:62473 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289099AbSBZXjO>;
	Tue, 26 Feb 2002 18:39:14 -0500
Date: Wed, 27 Feb 2002 00:39:05 +0100
From: Dave Jones <davej@suse.de>
To: Roberto Nibali <ratz@drugphish.ch>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.5-dj2
Message-ID: <20020227003905.C9189@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Roberto Nibali <ratz@drugphish.ch>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020226223406.A26905@suse.de> <3C7C1AF0.3000103@drugphish.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C7C1AF0.3000103@drugphish.ch>; from ratz@drugphish.ch on Wed, Feb 27, 2002 at 12:32:00AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 12:32:00AM +0100, Roberto Nibali wrote:

 > make distclean removes ../include/linux/version.h and thus your patch 
 > doesn't apply cleanly on a fresh 2.5.5 tree.

 Yup. All went well until ALSA arrived with its own version.h
 Before then, I had version.h in my diff exclusion list, and everything
 'just worked'. Oh well.. I'll add some more magic to autohch.pl[*]

 Dave.

 [*] my 'check for silly mistakes' script I run diffs through before
     uploading.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
