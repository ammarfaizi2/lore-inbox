Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265070AbTFUEXx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 00:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265076AbTFUEXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 00:23:53 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:26384 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S265070AbTFUEXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 00:23:52 -0400
Date: Sat, 21 Jun 2003 06:37:53 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: yiding_wang@agilent.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70/71 kernel compiler and loading issues
Message-ID: <20030621043753.GA990@mars.ravnborg.org>
Mail-Followup-To: yiding_wang@agilent.com,
	linux-kernel@vger.kernel.org
References: <334DD5C2ADAB9245B60F213F49C5EBCD05D551C3@axcs03.cos.agilent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <334DD5C2ADAB9245B60F213F49C5EBCD05D551C3@axcs03.cos.agilent.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 08:08:53PM -0600, yiding_wang@agilent.com wrote:
> Team,
> 
> I also tried 2.5.70 kernel on the same system, the compiler error is the same (The message is "Unknown Pseudo-op:  '.incbin'").

.incbin is not supported by binutils older than:
2.11.90.0.23 released on 2001-07-14

Please update your binutils.

	Sam
