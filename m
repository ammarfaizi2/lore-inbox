Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265350AbTFWTyb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 15:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266118AbTFWTyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 15:54:31 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:41220 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S265350AbTFWTya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 15:54:30 -0400
Date: Mon, 23 Jun 2003 22:08:37 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: yiding_wang@agilent.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.5.71 kernel compile error
Message-ID: <20030623200837.GA1044@mars.ravnborg.org>
Mail-Followup-To: yiding_wang@agilent.com,
	linux-kernel@vger.kernel.org
References: <334DD5C2ADAB9245B60F213F49C5EBCD05D551C2@axcs03.cos.agilent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <334DD5C2ADAB9245B60F213F49C5EBCD05D551C2@axcs03.cos.agilent.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 04:05:12PM -0600, yiding_wang@agilent.com wrote:
> Team,
> 
> I got failure on compiling the kernel in one of SuperMicro signle CPU system.  It has a Linux 2.4.2 on it.  
> The message is "Unknown Pseudo-op:  '.incbin'"

As per Documentation/Changes ld -v shall say at least: 2.12

You need to upgrade your binutils.

	Sam
