Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262576AbSJVN4g>; Tue, 22 Oct 2002 09:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262590AbSJVN4g>; Tue, 22 Oct 2002 09:56:36 -0400
Received: from users.linvision.com ([62.58.92.114]:37260 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S262576AbSJVN4g>; Tue, 22 Oct 2002 09:56:36 -0400
Date: Tue, 22 Oct 2002 16:02:42 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: System call wrapping
Message-ID: <20021022160242.A1575@bitwizard.nl>
References: <1035222121.1063.20.camel@pc177> <ap1g9a$pso$1@ncc1701.cistron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap1g9a$pso$1@ncc1701.cistron.net>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 06:16:10PM +0000, Miquel van Smoorenburg wrote:
> What is wrong with a preloaded library (by means of /etc/ld.so.preload)
> that intercepts open at the library level (and calls the real open()
> using RLTD_NEXT) ? Just let it talk over a unix socket to your
> scanner server.

Because you want to intercept ALL "open" system calls, not just those
of "friendly" users who agree to set LD_PRELOAD. 

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currenyly in such an      * 
* excursion: The stable situation does not include humans. ***************
