Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267797AbTAMN4K>; Mon, 13 Jan 2003 08:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267881AbTAMN4J>; Mon, 13 Jan 2003 08:56:09 -0500
Received: from gherkin.frus.com ([192.158.254.49]:6273 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id <S267797AbTAMN4J>;
	Mon, 13 Jan 2003 08:56:09 -0500
Subject: Re: patch for errno-issue (with soundcore)
In-Reply-To: <200301131457.24264.thomas.schlichter@web.de> "from Thomas Schlichter
 at Jan 13, 2003 02:57:53 pm"
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Date: Mon, 13 Jan 2003 08:04:59 -0600 (CST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20030113140459.269E34EE7@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy(0000))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Schlichter wrote:
> 
> here is a simple patch to export the errno-symbol from the /lib/errno.c file. 
> This solves the problem with the soundcore module and works perfectly for 
> me...

Alternatively, one could simply reverse the one-line patch to
linux/sound/sound_firmware.c in the 2.5.55 patch set that broke things
to begin with.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
