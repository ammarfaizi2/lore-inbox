Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRB0Nn3>; Tue, 27 Feb 2001 08:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129346AbRB0NnT>; Tue, 27 Feb 2001 08:43:19 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:59917 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129324AbRB0NnG>; Tue, 27 Feb 2001 08:43:06 -0500
Subject: Re: binfmt_script and ^M
To: irt@cistron.nl (Ivo Timmermans)
Date: Tue, 27 Feb 2001 13:44:08 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010227140333.C20415@cistron.nl> from "Ivo Timmermans" at Feb 27, 2001 02:03:33 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14XkQG-0003R7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When running a script (perl in this case) that has DOS-style newlines
> (\r\n), Linux 2.4.2 can't find an interpreter because it doesn't
> recognize the \r.  The following patch should fix this (untested).

Fix the script. The kernel expects a specific format

Alan

