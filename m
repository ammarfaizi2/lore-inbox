Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281967AbRKUUOz>; Wed, 21 Nov 2001 15:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281965AbRKUUOr>; Wed, 21 Nov 2001 15:14:47 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:17925 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S281967AbRKUUOf>; Wed, 21 Nov 2001 15:14:35 -0500
Date: Wed, 21 Nov 2001 21:14:33 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Heinz-Ado Arnolds <Ado.Arnolds@dhm-systems.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fs/exec.c and binfmt-xxx in 2.4.14
Message-ID: <20011121211433.B1424@devcon.net>
Mail-Followup-To: Heinz-Ado Arnolds <Ado.Arnolds@dhm-systems.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3BFBDD32.434AB47B@web-systems.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BFBDD32.434AB47B@web-systems.net>; from Ado.Arnolds@dhm-systems.de on Wed, Nov 21, 2001 at 05:58:26PM +0100
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2001 at 05:58:26PM +0100, Heinz-Ado Arnolds wrote:
> 
> When i now try to start an older binary in a.out format, which has a
> magic number of 0x010b0064, it is translated with the 'new' code to a
> request for "binfmt-0064" instead of "binfmt-267" as expected and
> properly handled by modprobe.

Then add

alias binfmt-0064 binfmt_aout

to /etc/modules.conf. Simple, isn't it?

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
