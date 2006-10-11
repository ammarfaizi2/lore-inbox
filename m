Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbWJKHAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWJKHAV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 03:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWJKHAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 03:00:21 -0400
Received: from usul.saidi.cx ([204.11.33.34]:15011 "EHLO usul.overt.org")
	by vger.kernel.org with ESMTP id S932445AbWJKHAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 03:00:19 -0400
Message-ID: <452C965A.6020409@overt.org>
Date: Tue, 10 Oct 2006 23:59:38 -0700
From: Philip Langdale <philipl@overt.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18 1/1] mmc: Add support for mmc v4 high speed mode
References: <21173.67.169.45.37.1159940502.squirrel@overt.org>    <452B3B00.5080209@drzeus.cx> <11208.67.169.45.37.1160545100.squirrel@overt.org> <452C87FB.6080302@drzeus.cx>
In-Reply-To: <452C87FB.6080302@drzeus.cx>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
> 
> In this case, it's protocol opcodes, which are far more vital to have
> readable. Currently we only use this in one place, but this will
> probably grow. If I understand things correctly, switching to 4-bit and
> 8-bit bus also uses the SWITCH command?

Correct. SWITCH is used to change the bus width. Now I have to stop
avoiding the issue and confront those crazy test commands so we can turn
on the wide-bus stuff properly. (You are happy with this diff now right? :-)

--phil
