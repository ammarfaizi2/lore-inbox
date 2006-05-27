Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbWE0KYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWE0KYm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 06:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWE0KYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 06:24:42 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:31209 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S1751034AbWE0KYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 06:24:41 -0400
Date: Sat, 27 May 2006 12:24:39 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: GIT <git@vger.kernel.org>, Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [SCRIPT] chomp: trim trailing whitespace
Message-ID: <20060527102439.GB26430@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	GIT <git@vger.kernel.org>, Jan Engelhardt <jengelh@linux01.gwdg.de>
References: <4477B905.9090806@garzik.org> <Pine.LNX.4.61.0605271212210.6670@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0605271212210.6670@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> #!/usr/bin/perl -i -p
> s/[ \t\r\n]+$//

perl -p -i -e 's/\s+$//' file1 file2 file3 ...

        Thomas
