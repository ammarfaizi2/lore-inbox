Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262143AbVCIJaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbVCIJaO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 04:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbVCIJaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 04:30:14 -0500
Received: from port-212-202-144-146.static.qsc.de ([212.202.144.146]:16875
	"EHLO mail.hennerich.de") by vger.kernel.org with ESMTP
	id S262143AbVCIJaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 04:30:09 -0500
Date: Wed, 9 Mar 2005 10:27:40 +0100
From: Tobias Hennerich <Tobias@Hennerich.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange memory leak in 2.6.x
Message-ID: <20050309102740.D3382@bart.hennerich.de>
References: <20050308133735.A13586@bart.hennerich.de> <20050308173811.0cd767c3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20050308173811.0cd767c3.akpm@osdl.org>; from akpm@osdl.org on Tue, Mar 08, 2005 at 05:38:11PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Mar 08, 2005 at 05:38:11PM -0800, Andrew Morton wrote:
> >  we kindly ask for some suggestions about how to trace a memory leak
> >  which we suspect in the linux kernel version 2.6:
> 
> Please grab 2.6.11, apply the below patch, set CONFIG_PAGE_OWNER and follow
> the below instructions.

thank you for you mails. We installed the patch from Alex on a test-system
last night and will switch it to the production machine this evening. The
problem will start after 48-72 hours, so we hope to send feedback
on friday.

Best regards	Tobias

-- 
T+T Hennerich GmbH --- Zettachring 12a --- 70567 Stuttgart
Fon:+49(711)720714-0  Fax:+49(711)720714-44  Vanity:+49(700)HENNERICH
UNIX - Linux - Java - C  Entwicklung/Beratung/Betreuung/Schulung
http://www.hennerich.de/
