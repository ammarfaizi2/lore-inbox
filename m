Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263432AbTECVA5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 17:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263434AbTECVA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 17:00:56 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22022 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263432AbTECVAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 17:00:55 -0400
Date: Sat, 3 May 2003 22:13:20 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Beat Bolli (privat)" <bbolli@ymail.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5 PCMCIA SERIAL] name mismatch in 8250_cs.c
Message-ID: <20030503221320.A9329@flint.arm.linux.org.uk>
Mail-Followup-To: "Beat Bolli (privat)" <bbolli@ymail.ch>,
	linux-kernel@vger.kernel.org
References: <3EB42FE0.9000900@ymail.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EB42FE0.9000900@ymail.ch>; from bbolli@ymail.ch on Sat, May 03, 2003 at 11:08:48PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 03, 2003 at 11:08:48PM +0200, Beat Bolli (privat) wrote:
> This seems to confuse the new module-init-tools, which try to modprobe 
> the module serial_cs which of course isn't found.
> 
> A manual "modprobe 8250_cs" works fine.

This may fall out of the wash when the rest of Dominiks driver model
changes go in.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

