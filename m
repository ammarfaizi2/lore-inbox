Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267216AbTBILpC>; Sun, 9 Feb 2003 06:45:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267217AbTBILpC>; Sun, 9 Feb 2003 06:45:02 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:18703 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S267216AbTBILpB>; Sun, 9 Feb 2003 06:45:01 -0500
Date: Sun, 9 Feb 2003 11:54:44 +0000
From: John Levon <levon@movementarian.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Switch APIC (+nmi, +oprofile) to driver model
Message-ID: <20030209115444.GA10576@compsoc.man.ac.uk>
References: <20030209113201.GA1296@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030209113201.GA1296@elf.ucw.cz>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18hq2m-000D3d-00*7cj8J0zMUcY*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 09, 2003 at 12:32:01PM +0100, Pavel Machek wrote:

> +	if (nmi_watchdog == NMI_LOCAL_APIC_SUSPENDED_BY_OPROFILE) {
> +		nmi_watchdog = NMI_LOCAL_APIC_SUSPENDED_BY_OPROFILE;

This is obviously wrong...

